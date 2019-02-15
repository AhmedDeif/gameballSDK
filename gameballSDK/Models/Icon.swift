//
//  Icon.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation


struct Icon: Codable {
    let id: String?
    let isDeleted: Bool?
    let name, fileName: String?
    let iconTypeID: Int?
    let creationDate, lastUpdate: String?
    let iconType: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case isDeleted
        case name = "Name"
        case fileName = "FileName"
        case iconTypeID = "IconTypeId"
        case creationDate = "CreationDate"
        case lastUpdate = "LastUpdate"
        case iconType = "IconType"
    }
}
