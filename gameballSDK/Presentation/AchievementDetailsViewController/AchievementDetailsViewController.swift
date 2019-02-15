//
//  AchievementDetailsViewController.swift
//  gameball_SDK
//
//  Created by Omar Ali on 2/8/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit


class AchievementDetailsViewController: BaseViewController {
    
    
    private let topContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.appGray239
        return view
    }()
    
    private let curvedView: UIView = {
        let view = DemoView(color: Colors.appGray239)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(actionOfBackButton), for: .touchUpInside)
        return button
    }()
    
    private let achievementImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "award"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let achievementTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appGray74
        label.font = Fonts.appFont20Bold
        label.textAlignment = .center
        label.text = "Electronics coin"
        label.numberOfLines = 0
        return label
    }()
    
    private let achievementDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appGray130
        label.font = Fonts.appFont16Regular
        label.textAlignment = .center
        label.text = "This is the description of the challenge"
        label.numberOfLines = 0
        return label
    }()
    
    private let achievementStatusImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "award"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let achievementStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appGray130
        label.font = Fonts.appFont16Regular
        label.textAlignment = .center
        label.text = "Keep Going ,earn this badge and claim your prize"
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.clipsToBounds = true
        addSubViews()
        addConstraints()
    }
    
    
    private func addSubViews() {
        view.addSubview(topContainerView)
        topContainerView.addSubview(curvedView)
        view.addSubview(backButton)
        topContainerView.addSubview(achievementImageView)
        topContainerView.addSubview(achievementTitleLabel)
        topContainerView.addSubview(achievementDescriptionLabel)
        view.addSubview(achievementStatusImageView)
        view.addSubview(achievementStatusLabel)
    }
    
    private func addConstraints() {
        
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        topContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        topContainerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        let height: CGFloat = 100
        curvedView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: -20).isActive = true
        curvedView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: 20).isActive = true
        curvedView.heightAnchor.constraint(equalToConstant: height).isActive = true
        curvedView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: height / 2).isActive = true
        
        achievementImageView.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: 60).isActive = true
        achievementImageView.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor).isActive = true
        achievementImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        achievementImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        achievementTitleLabel.topAnchor.constraint(equalTo: achievementImageView.bottomAnchor, constant: 10).isActive = true
        achievementTitleLabel.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: 30).isActive = true
        achievementTitleLabel.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -30).isActive = true
        
        achievementDescriptionLabel.topAnchor.constraint(equalTo: achievementTitleLabel.bottomAnchor, constant: 10).isActive = true
        achievementDescriptionLabel.leadingAnchor.constraint(equalTo: achievementTitleLabel.leadingAnchor, constant: 30).isActive = true
        achievementDescriptionLabel.trailingAnchor.constraint(equalTo: achievementTitleLabel.trailingAnchor, constant: -30).isActive = true
        
        
        achievementStatusImageView.topAnchor.constraint(equalTo: curvedView.bottomAnchor, constant: 60).isActive = true
        achievementStatusImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        achievementStatusImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        achievementStatusImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        achievementStatusLabel.topAnchor.constraint(equalTo: achievementStatusImageView.bottomAnchor, constant: 15).isActive = true
        achievementStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        achievementStatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
    }
    
    @objc private func actionOfBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
}



class DemoView: UIView {
    

    private var path: UIBezierPath!
    private let color: UIColor
    
    init(color: UIColor) {
        self.color = color
        super.init(frame: .zero)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        color = .clear
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        self.path = UIBezierPath(ovalIn: self.bounds)
        color.setFill()
        path.fill()
    }
    
}
