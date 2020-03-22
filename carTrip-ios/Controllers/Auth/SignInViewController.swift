//
//  SignInViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 16/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController {
    
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
    let presenter = SignInPresenter<SignInViewController>()
    
    // MARK: - @IBAction
    @IBAction func onLoginButtonTapped() {
        presenter.postLogIn()
        performSegue(withIdentifier: R.segue.signInViewController.showHome.identifier, sender: nil)
    }
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setUp()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        formView.roundCorners(radius: 25, corners: [.topRight, .topLeft])

        emailTextField.addShadowAndCornerRadius(cornerRadius: 10, color: .black)
        passwordTextField.addShadowAndCornerRadius(cornerRadius: 10, color: .black)
        loginButton.addShadowAndCornerRadius(cornerRadius: 10, color: .black)
    }
    
    
    // MARK: - Private Functions
    private func setUp() {
        titleLabel.text = R.string.localizable.welcome()
        titleLabel.font = .monospacedDigitSystemFont(ofSize: 30, weight: UIFont.Weight(rawValue: 0.2))
        titleLabel.textColor = .white
        
        topView.backgroundColor = .white
        
        formView.backgroundColor = .blueCar
        
        emailTextField.placeholder = R.string.localizable.email()
        
        passwordTextField.placeholder = R.string.localizable.password()
        
        loginButton.titleLabel?.text = R.string.localizable.signIn()
        signUpButton.titleLabel?.text = R.string.localizable.signUp()
        
        emailTextField.font = .monospacedDigitSystemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 0.3))
        passwordTextField.font = .monospacedDigitSystemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 0.3))
        
        loginButton.backgroundColor = .white
        loginButton.setTitle(R.string.localizable.signIn().capitalized, for: .normal)
        loginButton.tintColor = .blueCar
    
        
        signUpButton.setTitle(R.string.localizable.signUp(), for: .normal)
        
        let textRange = NSMakeRange(0, R.string.localizable.signUp().count)
        let attributedText = NSMutableAttributedString(string: R.string.localizable.signUp())
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        attributedText.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], range: textRange)

        signUpButton.setAttributedTitle(attributedText, for: .normal)
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField {
        case emailTextField:
            presenter.email = textField.text
        case passwordTextField:
            presenter.password = textField.text
        default:
            break
        }
    }
}


extension SignInViewController: SignInPresenterDelegate {
    
}
