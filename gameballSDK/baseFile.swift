//
//  baseFile.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/2/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit

public class baseFile: NSObject {
    
    public static func testFunc() {
//        print("SDK works")
//        print("attempting network request")
        
        NetworkManager.shared().registerAPIKey(APIKey: "8fdfd2dffd-9mnvhu25d6c3d")
        NetworkManager.shared().registerPlayer(playerId: "SomeGuid16")
        
        
        // Client BotSettings, this includes a client's color palette
//        let clientBotViewModel = ClientBotSettingsViewModel()
//        clientBotViewModel.getClientBotStyle { error in
//
//            if let requestError = error {
//                print(requestError.description)
//            }
//            else {
//                print(clientBotViewModel.botStyle)
//            }
//        }
        
        // Player Challenges with unlocks
//        let challengesViewModel = ChallengesViewModel()
//        challengesViewModel.getAllChallenges{ error in
//            if error != nil {
//                print(error?.description)
//            }
//            else {
//                print(challengesViewModel.challengesWithUnlocks)
//            }
//
//        }
        
        // Leaderboard
//        let leaderboardViewModel = LeaderboardViewModel()
//        leaderboardViewModel.getLeaderboard { (error) in
//            if error != nil {
//                print(error?.description)
//            }
//            else {
//                print("you can now access the leaderboard through the view model")
//                let ld = leaderboardViewModel.leaderboard
//            }
//        }
        
        // Player next level
//        let nextLevelViewModel = PlayerNextLevelViewModel()
//        nextLevelViewModel.getLeaderboard { (error) in
//            if error != nil {
//                print(error?.description)
//            }
//            else {
//                print("now you can access next level via view model")
//                let x = nextLevelViewModel.playerNextLevel
//            }
//        }
        
        // Player Details
//        let playerDetailsViewModel = PlayerDetailsViewModel()
//        playerDetailsViewModel.getPlayerDetails { (error) in
//            if error != nil {
//                print(error?.description)
//            }
//            else {
//                print("now you can access player details via view model")
//                let x = playerDetailsViewModel.playerDetails
//            }
//        }
        
    }
    
    
    
    public static func getImage( completition: @escaping ( _ :UIImage)->()){
        var resultImage = UIImage()
        NetworkManager.shared().loadImage(path: "/assets/images/bolt.png") { (myImage, error) in
            if let errorModel = error {
                print(errorModel.description)
            }
            if let result = myImage {
                resultImage =  result
            }
            completition(resultImage)
        }
    }
    
    open static func launchVC() -> UIViewController {
//        let myViewController = UIViewController(nibName: "GameballViewController", bundle: nil)
        let vc = GameballViewController()
        return vc
    }
    


}
