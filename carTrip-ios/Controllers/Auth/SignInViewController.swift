//
//  SignInViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 16/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class AuthNavigationController: UINavigationController, RegisterPresenterDelegate {
    
    func onLogin() {
        (viewControllers.last as? SignInViewController)?.onLogin()
    }
    
    func onRegister() {
        (viewControllers.last as? PersonalDataRegisterViewController)?.onRegister()
    }
    
    
    var authPresenter = RegisterPresenter<AuthNavigationController>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authPresenter.attachView(self)
    }
}

class RegisterBaseViewController: BaseViewController {
    var presenter: RegisterPresenter<AuthNavigationController>? {
        return (navigationController as? AuthNavigationController)?.authPresenter
    }
}


class SignInViewController: RegisterBaseViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet var topView: UIView!
    @IBOutlet var formView: CornerShadowView!
    @IBOutlet var emailTextField: CarTripTextField!
    @IBOutlet var passwordTextField: CarTripTextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    // MARK: - Properties
    weak var rootDelegate: RootViewControllerDelegate?
    
    // MARK: - @IBAction
    @IBAction func onLoginButtonTapped() {
        presenter?.loginUser()
    }
    
    @IBAction func goToRegister() {
        performSegue(withIdentifier: R.segue.signInViewController.goToRegister.identifier, sender: nil)
    }
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setUp()
        presenter?.setEmail("pato.bengoechea@gmail.com")
        presenter?.setPassword("admin")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        formView.roundCorners(radius: 25, corners: [.topRight, .topLeft])

        emailTextField.carTripRadius()
        passwordTextField.carTripRadius()
        loginButton.setCornerRadius(cornerRadius: 10)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? RegisterViewController {
            dest.rootDelegate = rootDelegate
        }
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
        emailTextField.backgroundColor = .white
        passwordTextField.font = .gothamRoundedMedium(14)
        passwordTextField.textColor = .darkGray
        passwordTextField.backgroundColor = .white
        
        loginButton.backgroundColor = .white
        loginButton.setTitle(R.string.localizable.signIn().capitalized, for: .normal)
        loginButton.titleLabel?.font = .gothamRoundedMedium(14)
        loginButton.tintColor = .blueCar
    
        
        signUpButton.setTitle(R.string.localizable.signUp(), for: .normal)
        
        let textRange = NSMakeRange(0, R.string.localizable.signUp().count)
        let attributedText = NSMutableAttributedString(string: R.string.localizable.signUp())
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
            presenter?.setEmail(textField.text)
        case passwordTextField:
            presenter?.setPassword(textField.text)
        default:
            break
        }
    }
}

// MARK: - Presenter Delegate
extension SignInViewController: RegisterPresenterDelegate {    
    func onLogin() {
        rootDelegate?.showHome()
    }
}
