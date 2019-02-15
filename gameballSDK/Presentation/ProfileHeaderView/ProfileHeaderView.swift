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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        Bundle.init(identifier: "Abodeif.gameball-SDK")?.loadNibNamed("ProfileHeaderView", owner: self, options: nil)
        Bundle.init(for: type(of: self)).loadNibNamed("ProfileHeaderView", owner: self, options: nil)
        self.addSubview(self.view);
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        commonInit()
    }
    
    private func commonInit() {
        progressView.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: Colors.appOrange, percentageFilled: 0.5)
//        setupViews()
        fetchData()
    }
    
    private func fetchData() {
        
        // ToDo: show loading animation
        self.viewModel.getPlayerDetails { (error) in
            if error != nil {
                // ToDo: Show message to user
            }
            else {
                if let model = self.viewModel.playerDetails {
                    self.setupView(fromModel: model)
                }
            }
            // ToDo: hide loading animation
        }
    }
    
    private func setupView(fromModel: PlayerDetails) {
        frubiesTitleLabel.text = "Frubies: "
        let frubiesValue = fromModel.accFrubies ?? 0
        frubiesValueLabel.text = String(frubiesValue)
        pointsTitleLabel.text = "Points: "
        let pointsValue = fromModel.accPoints ?? 0
        pointsValueLabel.text = String(pointsValue)
        customerTypeLabel.text = fromModel.name ?? "Player"
        
        nextTierTitleLabel.text = "Next tier after collecting"
        // ToDo: make call to fetch this value
        nextTierValueLabel.text = "200 F"
        var path = fromModel.level?.icon?.fileName ?? "assets/images/bolt.png"
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
    
    private func setupViews() {
        frubiesTitleLabel.text = "Frubies: "
        frubiesValueLabel.text = "735"
        pointsTitleLabel.text = "Points: "
        pointsValueLabel.text = "45"
        customerTypeLabel.text = "Gold Customer"
        nextTierTitleLabel.text = "Next tier after collecting"
        nextTierValueLabel.text = "200 F"
        profileIconImageView.image = UIImage(named: "award")
    }
    
    
    
    
    
}
