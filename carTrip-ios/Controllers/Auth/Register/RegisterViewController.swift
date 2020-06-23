//
//  RegisterViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 09/06/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

class RegisterViewController: RegisterBaseViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var emailTextField: CarTripTextField!
    @IBOutlet weak var passwordTextField: CarTripTextField!
    @IBOutlet weak var rePasswordTextField: CarTripTextField!
    @IBOutlet weak var haveAccountView: UIControl!
    @IBOutlet weak var haveAccountLabel: UILabel!

    // MARK: - Properties
    private var isValidEmail: Bool = false
    private var arePasswordsEqual: Bool = false
    weak var rootDelegate: RootViewControllerDelegate?
    
    // MARK: - @IBAction
    @IBAction func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        handleTextField(textField: sender)
    }
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        customize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bottomView.roundCorners(radius: 25, corners: [.topRight, .topLeft])
        
        emailTextField.carTripRadius()
        passwordTextField.carTripRadius()
        rePasswordTextField.carTripRadius()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? PersonalDataRegisterViewController {
            dest.rootDelegate = rootDelegate
        }
    }
    
    // MARK: - Functions
    
    // MARK: - Private functions
    private func customize() {
        topView.backgroundColor = .white
        logoImageView.image = R.image.freeLogo()
        
        bottomView.backgroundColor = .blueCar
        
        emailTextField.placeholder = R.string.localizable.email()
        emailTextField.font = .gothamRoundedMedium(14)
        
        passwordTextField.placeholder = R.string.localizable.password()
        passwordTextField.isSecureTextEntry = true
        
        rePasswordTextField.placeholder = R.string.localizable.password()
        rePasswordTextField.isSecureTextEntry = true
        
        haveAccountView.backgroundColor = .blueCar
        haveAccountLabel.set(font: .gothamRoundedLight(12), color: .white)
        haveAccountLabel.textAlignment = .center
        haveAccountLabel.text = R.string.localizable.alreadyHaveAccount().capitalizingFirstLetter()
    }
    
    private func handleTextField(textField: UITextField) {
        switch textField {
        case emailTextField:
            isValidEmail = Helper.isValidEmail(email: emailTextField.text ?? "")
            presenter?.setEmail(emailTextField.text)
            if isValidEmail {
                emailTextField.layer.borderColor = UIColor.green.cgColor
            } else {
                emailTextField.layer.borderColor = UIColor.red.cgColor
            }
        
        case passwordTextField:
            presenter?.setPassword(passwordTextField.text)
        
        case rePasswordTextField:
            if passwordTextField.text != rePasswordTextField.text {
                // Password are different
            } else {
                arePasswordsEqual = true
            }
        default:
            break
        }
    }
}

// MARK: - Presenter Delegate

// MARK: - Text Field Delegate
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            rePasswordTextField.becomeFirstResponder()
            
        case rePasswordTextField:
            if isValidEmail, arePasswordsEqual {
                performSegue(withIdentifier: R.segue.registerViewController.goToPersonalData, sender: nil)
            } else if !isValidEmail {
                emailTextField.becomeFirstResponder()
            } else if !arePasswordsEqual {
                passwordTextField.becomeFirstResponder()
            }
        default:
            break
        }
        
        return false
    }
    
}
