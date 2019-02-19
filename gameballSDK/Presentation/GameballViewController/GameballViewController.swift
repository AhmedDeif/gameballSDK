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
    
    private let challengesViewModel = ChallengesViewModel()
    private let leaderboardViewModel = LeaderboardViewModel()
    
    private var challenges: [Challenge] = []
    
    @IBOutlet weak var dismissButton: UIButton! {
        didSet {
            dismissButton.setTitle("Dismiss", for: .normal)
            dismissButton.setTitleColor(.black, for: .normal)
            dismissButton.addTarget(self, action: #selector(actionOfDismissButton), for: .touchUpInside)
        }
    }
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
        baseFile.testFunc()
        super.init(nibName: "GameballViewController", bundle: Bundle.init(for: type(of: self)))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        dropdownView.choices = ["Achievements", "Leaderboard"]
        fetchData()
        
    }
    
    private func fetchData() {
        // ToDo: start animation
        challengesViewModel.getAllChallenges { (error) in
            if error != nil {
                print(error?.description as Any)
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
    
    @objc private func actionOfDismissButton() {
        dismiss(animated: true, completion: nil)
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
       cell.challenge = challenge
        cell.setChallengeImage(fromModel: challenge)
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
        let vc = AchievementDetailsViewController(challenge: challenges[indexPath.row])
        push(vc, animated: true)
    }
    
}

extension GameballViewController: DropdownViewDelegate {
    func dropdownView(_ dropdownView: DropdownView, didSelectItemAt index: Int, for string: String) {
        if index == 1 {
            let vc = LeaderboardViewController()
            push(vc, animated: true)
        }
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
    
    private let lockView: UIView = {
        let iv = LockView(lockSize: .small)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    
    var challenge: Challenge? {
        didSet {
            guard let challange = challenge else { return }
            setupAchievementAppearance(with: challange)
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
        contentView.addSubview(lockView)
    }
    
    private func addConstraints() {
        achievementImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        achievementImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        achievementImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        achievementImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        lockView.topAnchor.constraint(equalTo: achievementImageView.topAnchor).isActive = true
        lockView.trailingAnchor.constraint(equalTo: achievementImageView.trailingAnchor).isActive = true
        lockView.heightAnchor.constraint(equalToConstant: 21.4).isActive = true
        lockView.widthAnchor.constraint(equalToConstant: 21.4).isActive = true
        
    }
    
    private func setupAchievementAppearance(with challenge: Challenge) {
        let isAchieved = (challenge.achievedCount ?? 0) > 0
        
        if isAchieved {
            achievementImageView.alpha = 1
        }
        else {
            achievementImageView.alpha = 0.5
        }
        
        lockView.isHidden = challenge.isUnlocked ?? false
        
    }
    
    func setChallengeImage(fromModel: Challenge) {
        
        var path = fromModel.icon ?? "assets/images/bolt.png"
        path = "/" + path
        NetworkManager.shared().loadImage(path: path) { (myImage, error) in
            if let errorModel = error {
                print(errorModel.description)
            }
            else {
            }
            if let result = myImage {
                DispatchQueue.main.async {
                    self.achievementImageView.image = result
                }
            }
        }
    }
    
    
}











