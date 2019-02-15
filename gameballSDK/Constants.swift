//
//  Constants.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/3/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation
import UIKit

struct APIEndPoints {
    static let base_URL = "http://18.188.207.253:8092"
    static let getBotStyle = "/api/Bots/GetClientBotSettings"
    static let getChallengesWithUnlocks = "/api/Bots/GetWithUnlocks"
    static let getLeaderboards = "/api/Bots/GetLeaderboard"
    static let getPlayerNextLevel = "/api/Bots/GetNextLevel"
    static let getPlayerDetails = "/api/Bots/GetPlayerDetails"
}

struct Colors {
    static let appGray173 = UIColor(white: 173 / 255, alpha: 1)
    static let appGray230 = UIColor(white: 230 / 255, alpha: 1)
    static let appGray103 = UIColor(white: 103 / 255, alpha: 1)
    static let appGray204 = UIColor(white: 204 / 255, alpha: 1)
    static let appGray239 = UIColor(white: 239 / 255, alpha: 1)
    static let appGray74 = UIColor(white: 74 / 255, alpha: 1)
    static let appGray130 = UIColor(white: 130 / 255, alpha: 1)
    static let appCustomDarkGray = UIColor(red: 68 / 255, green: 76 / 255, blue: 82 / 255, alpha: 1.0)
    
    static let appOrange = UIColor(red: 240 / 255, green: 90 / 255, blue: 42 / 255, alpha: 1.0)
}

struct Fonts {
    static let appFont14 = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    static let appFont18 = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
    static let appFont13 = UIFont.systemFont(ofSize: 13.0, weight: .semibold)
    static let appFont12 = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
    static let appFont12Light = UIFont.systemFont(ofSize: 12.0, weight: .light)
    static let appFont20Bold = UIFont.systemFont(ofSize: 20.0, weight: .bold)
    static let appFont16Regular = UIFont.systemFont(ofSize: 16.0, weight: .regular)
    
    
}
