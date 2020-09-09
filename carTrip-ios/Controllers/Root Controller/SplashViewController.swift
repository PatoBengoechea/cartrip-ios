//
//  SplashViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 16/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    weak var rootDelegate: RootViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
            if UserManager.sharedInstance.isLogged() {
                self.rootDelegate?.showHome()
            } else {
                self.rootDelegate?.showlogIn()
            }
        }
    }

}
