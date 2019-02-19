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
    
    private var leaderboardProfiles: [Profile] = []
    
    init() {
        super.init(nibName: "LeaderboardViewController", bundle: Bundle.init(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded leaderboard controller")
        fetchDate()
        // Do any additional setup after loading the view.
    }

    private func fetchDate() {
        let viewModel = LeaderboardViewModel()
        viewModel.getLeaderboard(completion: {
            [weak self] error in
            if error != nil {
                // handle error
                return
            }
            
            self?.leaderboardProfiles = viewModel.leaderboard
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
            
        })
    }

}

extension LeaderboardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboardProfiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! LeaderboardCell
        cell.profile = leaderboardProfiles[indexPath.row]
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




















