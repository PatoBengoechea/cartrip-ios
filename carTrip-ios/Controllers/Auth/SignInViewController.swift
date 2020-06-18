//
//  SignInViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 16/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

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
    }
    
    @IBAction func goToRegister() {
        performSegue(withIdentifier: R.segue.signInViewController.goToRegister.identifier, sender: nil)
    }
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        navigationController?.setNavigationBarHidden(true, animated: false)
        setUp()
        presenter.email = "pato.bengoechea@gmail.com"
        presenter.password = "admin"
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
        titleLabel.font = .gothamRoundedMedium(20)
        
        topView.backgroundColor = .white
        
        formView.backgroundColor = .blueCar
        
        emailTextField.placeholder = R.string.localizable.email()
        
        passwordTextField.placeholder = R.string.localizable.password()
        
        loginButton.titleLabel?.text = R.string.localizable.signIn()
        signUpButton.titleLabel?.text = R.string.localizable.signUp()
        
        emailTextField.font = .gothamRoundedMedium(14)
        emailTextField.textColor = .darkGray
        passwordTextField.font = .gothamRoundedMedium(14)
        passwordTextField.textColor = .darkGray
        
        loginButton.backgroundColor = .white
        loginButton.setTitle(R.string.localizable.signIn().capitalized, for: .normal)
        loginButton.titleLabel?.font = .gothamRoundedMedium(14)
        loginButton.tintColor = .blueCar
    
        
        signUpButton.setTitle(R.string.localizable.signUp(), for: .normal)
        
        let textRange = NSMakeRange(0, R.string.localizable.signUp().count)
        let attributedText = NSMutableAttributedString(string: R.string.localizable.signUp())
//        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        attributedText.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], range: textRange)
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.gothamRoundedLight(14)], range: textRange)

        signUpButton.setAttributedTitle(attributedText, for: .normal)
    }
}

// MARK: - Text Field Delegate
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

// MARK: - Presenter Delegate
extension SignInViewController: SignInPresenterDelegate {
    func onSuccesfullLogin() {
        performSegue(withIdentifier: R.segue.signInViewController.showHome.identifier, sender: nil)
    }
    
    func startLoading() {
        Loader.showLoader()
    }
    
    func finishedLoading() {
        Loader.dismiss()
    }
    
    func onError(message: String) {
        Loader.dismiss()
    }
}
