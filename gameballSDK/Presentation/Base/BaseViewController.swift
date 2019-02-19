//
//  BaseViewController.swift
//  gameball_SDK
//
//  Created by Omar Ali on 2/8/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController {
    
    private var loadingView: UIView?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func startLoading(with loadingView: UIView) {
        self.loadingView = loadingView
        self.view.addSubview(loadingView)
        loadingView.frame = view.bounds
        
        
    }
    
    func stopLoading() {
        self.loadingView?.removeFromSuperview()
        self.loadingView = nil
    }
    
    
}

extension BaseViewController: BaseCoordinatorDelegate {
    func push(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
