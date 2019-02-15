//
//  ChallengesViewModel.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation


class ChallengesViewModel {
    
    var challengesWithUnlocks: [Challenge] = []
    var networkRequestInProgess = false
    
    
    func getAllChallenges( completion: @escaping ((_ error: ServiceError?)->())) {
        self.networkRequestInProgess = true
        NetworkManager.shared().load(path: APIEndPoints.getChallengesWithUnlocks, method: .GET, params: ["externalId":NetworkManager.shared().playerId], modelType: GetChallengeWithUnlocksResponseModel.self) { (data, error) in
            if let errorModel = error {
                print(errorModel.description)
                completion(errorModel)
                self.networkRequestInProgess = false
                return
            }
            if data != nil {
                self.challengesWithUnlocks = (data as! GetChallengeWithUnlocksResponseModel).response
                self.networkRequestInProgess = false
                completion(nil)
            }
        }
    }
    
    
    func onSuccess() {
        self.networkRequestInProgess = false
    }
    
    func onFailure() {
        self.networkRequestInProgess = false
    }
    
}
