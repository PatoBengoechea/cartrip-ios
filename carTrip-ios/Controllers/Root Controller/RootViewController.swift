//
//  RootViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 16/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

protocol RootViewControllerDelegate: AnyObject {
    func showlogIn()
    func showHome()
}

class RootViewController: UIViewController {

    // MARK: - Properties
    
    static var instance = RootViewController()
    private var _logInNavigationController: UINavigationController?
    private var _homeNavigationController: UINavigationController?

    var loginNavigationController: UINavigationController {
        if _logInNavigationController == nil {
            _logInNavigationController = UINavigationController.initFrom(R.storyboard.auth.name)
            if let nav = _logInNavigationController, let cont = nav.root as? SignInViewController {
                cont.rootDelegate = self
                return nav
            }
        }
        return _logInNavigationController!
    }

    var homeNavigationController: UINavigationController {
        if _homeNavigationController == nil {
            _homeNavigationController = UINavigationController.initFrom(R.storyboard.home.name)
            if let nav = _homeNavigationController, let cont = nav.root as? HomeViewController {
                cont.rootDelegate = self
                return nav
            }
        }
        return _homeNavigationController!
    }
    
    // MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        RootViewController.instance = self
        performSegue(withIdentifier: R.segue.rootViewController.goToSplash, sender: nil)
    }
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let splashVC = segue.destination as? SplashViewController {
            splashVC.rootDelegate = self
        }
    
    }
}

extension RootViewController: RootViewControllerDelegate {
    func showlogIn() {
        UIApplication.shared.keyWindow?.rootViewController = loginNavigationController
    }
    
    func showHome() {
        UIApplication.shared.keyWindow?.rootViewController = homeNavigationController
    }
    
}
