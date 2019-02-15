//
//  LeaderboardViewController.swift
//  gameball_SDK
//
//  Created by Omar Ali on 2/9/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit

class LeaderboardViewController: BaseViewController {

    private let cellId = "Cell"
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.separatorStyle = .none
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(LeaderboardCell.self, forCellReuseIdentifier: cellId)
        }
    }
    
    init() {
        super.init(nibName: "LeaderboardViewController", bundle: Bundle.init(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded leaderboard controller")
        // Do any additional setup after loading the view.
    }



}

extension LeaderboardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! LeaderboardCell
        cell.setProperties()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = LeaderboardHeaderView()
        view.setProperties()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return LeaderboardHeaderView.height
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = LoadMoreView()
        view.buttonPressedAction = {
            print("Load more")
        }
        return view
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return LoadMoreView.height
    }
}










class LeaderboardCell: UITableViewCell {
    
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "award"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let playerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appGray103
        label.font = Fonts.appFont14
        return label
    }()
    
    private let playerLevelNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appCustomDarkGray
        label.font = Fonts.appFont12Light
        return label
    }()
    
    private lazy var  playerInfoStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [playerNameLabel, playerLevelNameLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.spacing = 4.0
        return sv
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.appGray204
        return view
    }()
    
//    private let frubiesTitleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .black
//        return label
//    }()
//
//    private let frubiesValueLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .black
//        label.textAlignment = .center
//        return label
//    }()
//
//    private lazy var  frubiesStackView: UIStackView = {
//        let sv = UIStackView(arrangedSubviews: [frubiesTitleLabel, frubiesValueLabel])
//        sv.translatesAutoresizingMaskIntoConstraints = false
//        sv.axis = .vertical
//        sv.distribution = .equalSpacing
//        return sv
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews()
        addConstraints()
        
    }
    
    
    private func addSubviews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(playerInfoStackView)
        contentView.addSubview(separatorView)
//        contentView.addSubview(frubiesStackView)
    }
    
    private func addConstraints() {
        
        let height: CGFloat = 58
        let topSpacing: CGFloat = 17
        profileImageView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: height).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topSpacing).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -topSpacing).isActive = true
        
        playerInfoStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 14).isActive = true
        playerInfoStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        
        separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
//        frubiesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
//        frubiesStackView.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 5).isActive = true
//        frubiesStackView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -5).isActive = true
        
        
    }
    
    func setProperties() {
        
       
        
        let string1 = NSMutableAttributedString(string: "Level Name . Fr ", attributes: [
            NSAttributedString.Key.font: Fonts.appFont12Light,
            NSAttributedString.Key.foregroundColor: Colors.appCustomDarkGray
            ])
        
        let string2 = NSMutableAttributedString(string: "34", attributes: [
            NSAttributedString.Key.font: Fonts.appFont12,
            NSAttributedString.Key.foregroundColor: Colors.appCustomDarkGray
            ])
        
        string1.append(string2)
        
        playerLevelNameLabel.attributedText = string1
        
        playerNameLabel.text = "Player Name"
//        playerLevelNameLabel.text = "Level Name . Fr "
//        frubiesTitleLabel.text = "Frubies"
//        frubiesValueLabel.text = "7,853"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




class LeaderboardHeaderView: UIView {
    
    static var height: CGFloat {
        return 80
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appOrange
        label.font = Fonts.appFont20Bold
        label.text = "Leaderboard"
        return label
    }()
    
    private let playerRankingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = Colors.appCustomDarkGray
        label.font = Fonts.appFont12Light
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.appGray204
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
        addubviews()
        addConstraints()
    }
    
    private func addubviews() {
        addSubview(titleLabel)
        addSubview(playerRankingLabel)
        addSubview(separatorView)
    }
    
    private func addConstraints() {
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        
        playerRankingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        playerRankingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        playerRankingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 30).isActive = true
        
        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        
    }
    
    func setProperties() {
        playerRankingLabel.text = "Your rank in the leaderboard is 182"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LoadMoreView: UIView {
    
    static var height: CGFloat {
        return 30
    }
    
    var buttonPressedAction: (() -> Void)?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Load More", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.addTarget(self, action: #selector(actionOfButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
        addubviews()
        addConstraints()
    }
    
    
    
    private func addubviews() {
        addSubview(button)
    }
    
    private func addConstraints() {
        
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
 
    }
    
    @objc private func actionOfButton() {
        buttonPressedAction?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




