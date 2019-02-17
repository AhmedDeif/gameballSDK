//
//  GameballViewController.swift
//  GameBallDemo
//
//  Created by Omar Ali on 2/1/19.
//  Copyright © 2019 Omar Ali. All rights reserved.
//

import UIKit

public class GameballViewController: BaseViewController {


    private let cellIdentifier = "Cell"
    private let coordinator: GameballCoordinator
    
    private let challengesViewModel = ChallengesViewModel()
    private let leaderboardViewModel = LeaderboardViewModel()
    
    private var challenges: [Challenge] = []
    
    @IBOutlet private weak var profileHeaderView: ProfileHeaderView!
    @IBOutlet weak var dropdownView: DropdownView! {
        didSet {
            dropdownView.delegate = self
        }
    }
    @IBOutlet private weak var separaterView: UIView! {
        didSet {
            separaterView.backgroundColor = Colors.appGray204
        }
    }
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(AchievementCell.self, forCellWithReuseIdentifier: cellIdentifier)
        }
    }
    
    public init() {
        coordinator = GameballCoordinator()
//        let bund = Bundle.init(for: type(of: self))
//        Bundle(for: GameballViewController.self)
        super.init(nibName: "GameballViewController", bundle: Bundle.init(for: type(of: self)))
        coordinator.delegate = self
        fetchData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        dropdownView.choices = ["Achievements", "Leaderboard"]
        
    }
    
    func fetchData() {
        // ToDo: start animation
        challengesViewModel.getAllChallenges { (error) in
            if error != nil {
                print(error?.description)
            }
            else {
                // ToDo: stop animation
                self.challenges = self.challengesViewModel.challengesWithUnlocks
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
    }

}

extension GameballViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.challenges.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AchievementCell
        let challenge = self.challenges[indexPath.row]
        cell.properties = (isAchieved: challenge.isUnlocked ?? false, isLocked: true) // will be changed to model
        cell.setCellData(fromModel: challenge)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 70) / 3
        return CGSize(width: width, height: width)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator.didSelectAchievement()
    }
    
}

extension GameballViewController: DropdownViewDelegate {
    func dropdownView(_ dropdownView: DropdownView, didSelectItemAt index: Int, for string: String) {
        if index == 1 {
            coordinator.showLeaderboard()
        }
    }
}


extension GameballViewController: GameballCoordinatorDelegate {
    func profileDetailsReady() {
        
    }
}













class AchievementCell: UICollectionViewCell {
    
    private let achievementImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "award"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let lockImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "award"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let challengeNameUILabel: UILabel = {
        let label =  UILabel()
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        label.textColor = Colors.appGray74
        label.textAlignment = .center
        label.text = "This is two lines name"
        label.numberOfLines = 0
        label.font = label.font.withSize(11)
        
        return label
    }()
    
    
    var properties: (isAchieved: Bool, isLocked: Bool)? {
        didSet {
            guard let properties = properties else { return }
            setupAchievementAppearance(isAchieved: properties.isAchieved, isLocked: properties.isLocked)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubViews()
        addConstraints()
    }
    
    private func addSubViews() {
        contentView.addSubview(achievementImageView)
        contentView.addSubview(lockImageView)
        contentView.addSubview(challengeNameUILabel)
    }
    
    private func addConstraints() {
        
        achievementImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        achievementImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        achievementImageView.heightAnchor.constraint(equalTo: achievementImageView.widthAnchor, multiplier: 1).isActive = true
        achievementImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        challengeNameUILabel.frame = CGRect(x: 10, y: contentView.frame.height - 20, width: contentView.frame.width-10, height: 30)
        challengeNameUILabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        challengeNameUILabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    private func setupAchievementAppearance(isAchieved: Bool, isLocked: Bool) {
        
        if isAchieved {
            achievementImageView.alpha = 1
        }
        else {
            achievementImageView.alpha = 0.5
        }
        
        lockImageView.isHidden = !isLocked
        
    }
    
    
    func setCellData(fromModel: Challenge) {
        self.setChallengeName(name: fromModel.gameName ?? "Challenge")
        var path = fromModel.icon ?? "assets/images/bolt.png"
        path = "/" + path
        self.setChallengeImage(imagePath: path)
    }
    
    func setChallengeImage(imagePath: String) {
        
        self.contentView.startShimmering()
        NetworkManager.shared().loadImage(path: imagePath) { (myImage, error) in
            if let errorModel = error {
                print(errorModel.description)
            }
            else {
            }
            if let result = myImage {
                DispatchQueue.main.async {
                    self.contentView.stopShimmering()
                    self.achievementImageView.image = result
                }
            }
        }
    }
    
    
    func setChallengeName(name: String) {
        challengeNameUILabel.text = name
    }
    
    
}
