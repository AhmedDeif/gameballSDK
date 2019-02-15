//
//  NetworkManager.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/3/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

class NetworkManager:NSObject {
    
    let urlSession: URLSession
    let baseURL: String
    let connectionScheme: String
    let host: String
    let port: Int
    var APIKey: String
    var playerId: String
    
    private static var sharedManager:NetworkManager = {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.waitsForConnectivity = true
        let urlSession = URLSession(configuration: sessionConfiguration)
        let baseURL = APIEndPoints.base_URL
        let scheme = "http"
        let host = "ec2-3-16-47-245.us-east-2.compute.amazonaws.com"
        let port = 8092
        let APIKey = ""
        let playerId = ""
        let networkManager = NetworkManager.init(urlSession: urlSession, connectionScheme: scheme, host: host, port: port, APIKey: APIKey, playerId: playerId)
        return networkManager
    }()
    
    
    private init(urlSession: URLSession, connectionScheme: String, host: String, port: Int, APIKey: String, playerId: String) {
        self.urlSession = urlSession
        self.connectionScheme = connectionScheme
        self.host = host
        self.port = port
        self.baseURL = ""
        self.APIKey = APIKey
        self.playerId = playerId
    }
    
    
    static func shared() -> NetworkManager {
        return sharedManager
    }
    
    

    func loadDebug<T>(path: String, method: RequestMethod, params: JSON, modelType: T.Type, completion: @escaping (Any?, ServiceError?) -> ()) where T:Codable {
        
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, ServiceError.noInternetConnection)
            return
        }
        
        var request = URLRequest(path: path, method: method, params: params)
        self.adaptRequest(urlRequest: &request)
        // Sending request to the server.
        let task = self.urlSession.dataTask(with: request) { data, response, error in
            // Parsing incoming data
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case (200..<300):
                    if let data = data {
                        let JSONString = String(data: data, encoding: String.Encoding.utf8)
                        print(JSONString ?? "Could not print Json")
                    }
                case 403:
                    completion(nil, ServiceError.missingAPIKey)
                case 401:
                    completion(nil, ServiceError.invalidAPIKey)
                default:
                    completion(nil, ServiceError.serverError)
                }
            }
            
            if let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
                completion(nil, nil)
            } else {
                completion(nil, ServiceError.serverError)
            }
        }
        
        task.resume()
    }

    
    func load<T>(path: String, method: RequestMethod, params: JSON, modelType: T.Type, completion: @escaping (Any?, ServiceError?) -> ()) where T:Codable {
        
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, ServiceError.noInternetConnection)
            return
        }
        
        var request = URLRequest(path: path, method: method, params: params)
        self.adaptRequest(urlRequest: &request)
        // Sending request to the server.
        let task = self.urlSession.dataTask(with: request) { data, response, error in
            var object: T? = nil
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case (200..<300):
                    // Parsing incoming data
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(modelType.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        object = tempObject
                        completion(object, nil)
                    }
                case 403:
                    completion(nil, ServiceError.missingAPIKey)
                case 401:
                    completion(nil, ServiceError.invalidAPIKey)
                default:
                    completion(nil, ServiceError.serverError)
                }
            }
        }
        
        task.resume()
    }
    
    
    func loadImage(path: String, completion: @escaping (UIImage?, ServiceError?) -> ()) {
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, ServiceError.noInternetConnection)
            return
        }
        var request = URLRequest(path: path)
        self.adaptRequest(urlRequest: &request)
        let task = self.urlSession.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    completion(image, nil)
                }
                else {
                    let errorObject = ["ErrorMsg":"The image file seems to be corrupted, check the URL: \(String(describing: request.url?.absoluteString))"]
                    let error = ServiceError.init(json: errorObject)
                    completion(nil, error)
                }
            } else {
                completion(nil, ServiceError.serverError)
            }
        }
        task.resume()
    }

    
    func adaptRequest(urlRequest: inout URLRequest) {
        if NetworkManager.shared().APIKey.count > 0 {
            urlRequest.addValue(NetworkManager.shared().APIKey, forHTTPHeaderField: "APIKey")
        }
    }
    
    func registerAPIKey(APIKey: String) {
        NetworkManager.shared().APIKey = APIKey
    }
    
    func registerPlayer(playerId: String) {
        NetworkManager.shared().playerId = playerId
    }
    
    func deRegisterPlayer() {
        NetworkManager.shared().playerId = ""
    }
    
}

extension URL {
    init(path: String, params: JSON , method: RequestMethod) {
        
        var components = URLComponents()
        components.scheme = NetworkManager.shared().connectionScheme
        components.host = NetworkManager.shared().host
        components.port = NetworkManager.shared().port
        components.path += path
        if params.count > 0 {
            switch method {
            case .GET, .DELETE:
                components.queryItems = params.map {
                    URLQueryItem(name: $0.key, value: String(describing: $0.value))
                }
            default:
                break
            }
        }
        print(components.url!)
        self = components.url!
    }
}

extension URLRequest {
    init(path: String, method: RequestMethod = .GET, params: JSON = [:]) {
        let url = URL(path: path, params: params, method: method)
        self.init(url: url)
        httpMethod = method.rawValue
//        setValue("application/json", forHTTPHeaderField: "Accept")
//        setValue("application/json", forHTTPHeaderField: "Content-Type")
        switch method {
        case .POST, .PUT:
            httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        default:
            break
        }
    }
    
}
