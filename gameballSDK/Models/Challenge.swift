//
//  Challenge.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/6/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation

class Challenge: Codable {
    let gameName: String?
    let challengeID: Int?
    let icon, description: String?
    let isUnlocked: Bool?
    let activationCriteriaTypeID: Int?
    let activationFrubes, activationLevel: Int?
    let levelName: String?
    let behaviorTypeID: Int?
    let targetActionsCount, targetAmount: Int?
    let actionsCompletedPercentage: Double?
    let amountCompletedPercentage: Int?
    let actionsAndAmountCompletedPercentage: Double?
    let isRepeatable: Bool?
    let achievedCount, achievedActionsCount, currentAmount: Int?
    let userMessage: String?
    
    var status: ChallengeStatus {
        
        guard let isUnlocked = isUnlocked, let achievedCount = achievedCount else {
            return .locked
        }
        if !isUnlocked {
            return .locked
        }
        else if achievedCount > 0 {
            return .achieved
        }
        else {
            return .inProgress
        }
        
        
    }
    
    var statusDescription: String {
        switch status {
        case .locked:
            return "Locked! You need to be on level “Level Name Here” to unlock this badge"
        case .inProgress:
            return "Keep going! Earn this badge and claim your prize "
        case .achieved:
            return "Achieved (1)"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case gameName = "GameName"
        case challengeID = "ChallengeId"
        case icon = "Icon"
        case description = "Description"
        case isUnlocked = "IsUnlocked"
        case activationCriteriaTypeID = "ActivationCriteriaTypeId"
        case activationFrubes = "ActivationFrubes"
        case activationLevel = "ActivationLevel"
        case levelName = "LevelName"
        case behaviorTypeID = "BehaviorTypeId"
        case targetActionsCount = "TargetActionsCount"
        case targetAmount = "TargetAmount"
        case actionsCompletedPercentage = "ActionsCompletedPercentage"
        case amountCompletedPercentage = "AmountCompletedPercentage"
        case actionsAndAmountCompletedPercentage = "ActionsAndAmountCompletedPercentage"
        case isRepeatable = "IsRepeatable"
        case achievedCount = "AchievedCount"
        case achievedActionsCount = "AchievedActionsCount"
        case currentAmount = "CurrentAmount"
        case userMessage = "UserMessage"
    }
    
}

enum ChallengeStatus {
    case locked
    case inProgress
    case achieved
}
