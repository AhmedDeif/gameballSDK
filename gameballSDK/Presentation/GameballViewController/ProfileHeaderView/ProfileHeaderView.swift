//
//  ProfileHeaderView.swift
//  GameBallDemo
//
//  Created by Omar Ali on 2/1/19.
//  Copyright © 2019 Omar Ali. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    var viewModel: PlayerDetailsViewModel = PlayerDetailsViewModel()
    
    @IBOutlet var view: UIView!
    
    @IBOutlet private weak var profileIconImageView: UIImageView!
    @IBOutlet private weak var progressView: ProgressView!
    @IBOutlet private weak var frubiesTitleLabel: UILabel! {
        didSet {
            frubiesTitleLabel.text = "Frubies: "
            frubiesTitleLabel.textColor = Colors.appGray173
            frubiesTitleLabel.font = Fonts.appFont14
        }
    }
    @IBOutlet private weak var frubiesValueLabel: UILabel! {
        didSet {
            
            frubiesValueLabel.textColor = Colors.appGray103
            frubiesValueLabel.font = Fonts.appFont14
        }
    }
    @IBOutlet private weak var pointsTitleLabel: UILabel! {
        didSet {
            pointsTitleLabel.text = "Points: "
            pointsTitleLabel.textColor = Colors.appGray173
            pointsTitleLabel.font = Fonts.appFont14
        }
    }
    @IBOutlet private weak var pointsValueLabel: UILabel! {
        didSet {
            pointsValueLabel.textColor = Colors.appGray103
            pointsValueLabel.font = Fonts.appFont14
        }
    }
    @IBOutlet private weak var customerTypeLabel: UILabel! {
        didSet {
            customerTypeLabel.textColor = Colors.appCustomDarkGray
            customerTypeLabel.font = Fonts.appFont18
        }
    }
    @IBOutlet private weak var nextTierTitleLabel: UILabel! {
        didSet {
            nextTierTitleLabel.text = "Next tier after collecting"
            nextTierTitleLabel.textColor = Colors.appGray173
            nextTierTitleLabel.font = Fonts.appFont13
        }
    }
    @IBOutlet private weak var nextTierValueLabel: UILabel! {
        didSet {
            nextTierValueLabel.textColor = Colors.appGray173
            nextTierValueLabel.font = Fonts.appFont13
        }
    }
    
    private var playerDetails: PlayerDetails? {
        didSet {
            guard let playerDetails = playerDetails else { return }
            DispatchQueue.main.async {
                [weak self] in
                self?.setupView(with: playerDetails)
            }
            
        }
    }
    
    private var playerNextLevel: PlayerNextLevel? {
        didSet {
            guard let playerNextLevel = playerNextLevel else { return }
            DispatchQueue.main.async {
                self.setupPlayerNextLevel(with: playerNextLevel)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.init(for: type(of: self)).loadNibNamed("ProfileHeaderView", owner: self, options: nil)
        self.addSubview(self.view);
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        commonInit()
    }
    
    private func commonInit() {
//        progressView.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: Colors.appOrange, percentageFilled: 0.5)
//        setupViews()
        fetchData()
    }
    
    private func fetchData() {
        
        fetchPlayerDetails()
        
        
        
        
        
    }
    
    private func fetchPlayerDetails() {
        // ToDo: show loading animation
        self.viewModel.getPlayerDetails {
            [weak self] error in
            if error != nil {
                // ToDo: Show message to user
            }
            else {
                if let model = self?.viewModel.playerDetails {
                    self?.playerDetails = model
                }
                self?.fetchNextLevel()
            }
            // ToDo: hide loading animation
        }
    }
    
    private func fetchNextLevel() {
        let playerNextLevelViewModel = PlayerNextLevelViewModel()
        playerNextLevelViewModel.getLeaderboard(completion: {
            [weak self] error in
            if error != nil {
                // handle error
                return
            }
            
            self?.playerNextLevel = playerNextLevelViewModel.playerNextLevel
            
            
        })
    }
    
    
    private func setupView(with model: PlayerDetails) {
        
        let frubiesValue = model.accFrubies ?? 0
        frubiesValueLabel.text = String(frubiesValue)
        
        let pointsValue = model.accPoints ?? 0
        pointsValueLabel.text = String(pointsValue)
        customerTypeLabel.text = model.name ?? "Player"
        
        
        var path = model.level?.icon?.fileName ?? "assets/images/bolt.png"
        path = "/" + path
        NetworkManager.shared().loadImage(path: path) { (myImage, error) in
            if let errorModel = error {
                print(errorModel.description)
            }
            else {
            }
            if let result = myImage {
                DispatchQueue.main.async {
                    self.profileIconImageView.image = result
                }
            }
        }


    }
    
    private func setupPlayerNextLevel(with playerNextLevel: PlayerNextLevel) {
        
        if let currentFrubies = playerDetails?.accFrubies, let targetFrubies = playerNextLevel.levelFrubies {
            let percentageFilled = Float(currentFrubies) / Float(targetFrubies)
            progressView.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: Colors.appOrange, percentageFilled: percentageFilled)
        }
        
        
        
        nextTierValueLabel.text = "\(playerNextLevel.levelFrubies ?? 0) F"
        
        
        
    }
    
    
    
    
//    private func setupViews() {
//        frubiesTitleLabel.text = "Frubies: "
//        frubiesValueLabel.text = "735"
//        pointsTitleLabel.text = "Points: "
//        pointsValueLabel.text = "45"
//        customerTypeLabel.text = "Gold Customer"
//        nextTierTitleLabel.text = "Next tier after collecting"
//        nextTierValueLabel.text = "200 F"
//        profileIconImageView.image = UIImage(named: "award")
//    }
    
    
    
    
    
}
