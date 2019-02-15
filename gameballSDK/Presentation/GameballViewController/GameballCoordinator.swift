//
//  GameballCoordinator.swift
//  GameBallDemo
//
//  Created by Omar Ali on 2/5/19.
//  Copyright © 2019 Omar Ali. All rights reserved.
//

import Foundation


protocol GameballCoordinatorDelegate: BaseCoordinatorDelegate {
    func profileDetailsReady()
}

class GameballCoordinator: NSObject {
    
    weak var delegate: GameballCoordinatorDelegate?
    
    
    
    override init() {
        super.init()
    }
    
    func didSelectAchievement() {
        let vc = AchievementDetailsViewController()
        delegate?.push(vc, animated: true)
    }
    
    func showLeaderboard() {
        let vc = LeaderboardViewController()
        delegate?.push(vc, animated: true)
    }
    
    private func getProfile() {
        
        
    }
    
    
    
}
















