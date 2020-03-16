//
//  SignInViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 16/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet var topView: UIView!
    @IBOutlet var formView: CornerShadowView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    // MARK: - Properties
    weak var rootDelegate: RootViewControllerDelegate?
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setUp()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        formView.addShadowAndCornerRadius(cornerRadius: 25, color: .black)
        
        loginButton.roundCorners(radius: 10, corners: .allCorners)

        
        emailTextField.layer.cornerRadius = 20
        emailTextField.layer.borderColor = UIColor.primaryGreen.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.clipsToBounds = true
        
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.layer.borderColor = UIColor.primaryGreen.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.clipsToBounds = true
    }
    
    
    // MARK: - Private Functions
    private func setUp() {
        titleLabel.text = R.string.localizable.welcome()
        titleLabel.font = .monospacedDigitSystemFont(ofSize: 30, weight: UIFont.Weight(rawValue: 0.2))
        titleLabel.textColor = .black
        titleLabel.alpha = 0.3
        
        topView.backgroundColor = .primaryGreen
        
        emailTextField.placeholder = R.string.localizable.email()
        
        passwordTextField.placeholder = R.string.localizable.password()
        
        loginButton.titleLabel?.text = R.string.localizable.signIn()
        signUpButton.titleLabel?.text = R.string.localizable.signUp()
        
        emailTextField.font = .monospacedDigitSystemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 0.3))
        passwordTextField.font = .monospacedDigitSystemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 0.3))
        
        loginButton.backgroundColor = .primaryGreen
        loginButton.setTitle(R.string.localizable.signIn().capitalized, for: .normal)
        loginButton.tintColor = .white
    
        
        signUpButton.setTitle(R.string.localizable.signUp(), for: .normal)
        
        let textRange = NSMakeRange(0, R.string.localizable.signUp().count)
        let attributedText = NSMutableAttributedString(string: R.string.localizable.signUp())
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        attributedText.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], range: textRange)

        signUpButton.setAttributedTitle(attributedText, for: .normal)
    }
}
