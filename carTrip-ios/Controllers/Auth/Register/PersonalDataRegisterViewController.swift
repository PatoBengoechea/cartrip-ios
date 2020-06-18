//
//  PersonalDataRegisterViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 17/06/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

class PersonalDataRegisterViewController: RegisterBaseViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dniTextField: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var haveAccountView: UIControl!
    @IBOutlet weak var haveAccountLabel: UILabel!

    // MARK: - Properties
    
    // MARK: - @IBActions
    @IBAction func textChange(_ sender: UITextField) {
        handleTextField(sender)
    }
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        customize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bottomView.roundCorners(radius: 25, corners: [.topRight, .topLeft])
        
        nameTextField.addShadowAndCornerRadius(cornerRadius: 10, color: .black)
        lastNameTextField.addShadowAndCornerRadius(cornerRadius: 10, color: .black)
        dniTextField.addShadowAndCornerRadius(cornerRadius: 10, color: .black)
        
    }
    
    // MARK: - Private Functions
    private func customize() {
        topView.backgroundColor = .white
        logoImageView.image = R.image.freeLogo()
        
        bottomView.backgroundColor = .blueCar
        
        nameTextField.placeholder = R.string.localizable.name()
        nameTextField.font = .gothamRoundedMedium(14)
        
        lastNameTextField.placeholder = R.string.localizable.lastName()
        lastNameTextField.font = .gothamRoundedMedium(14)
        
        dniTextField.placeholder = R.string.localizable.dnI()
        dniTextField.font = .gothamRoundedMedium(14)
        
        birthDatePicker.maximumDate = Date()
        
        haveAccountView.backgroundColor = .blueCar
        haveAccountLabel.set(font: .gothamRoundedLight(12), color: .white)
        haveAccountLabel.textAlignment = .center
        haveAccountLabel.text = R.string.localizable.alreadyHaveAccount().capitalizingFirstLetter()
    }
    
    private func handleTextField(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            presenter?.setName(nameTextField.text)
        
        case lastNameTextField:
            presenter?.setLastName(lastNameTextField.text)
            
        case dniTextField:
            presenter?.setDNI(dniTextField.text)
        default:
            break
        }
    }
}

// MARK: UI Text Field Delegate
extension PersonalDataRegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            nameTextField.resignFirstResponder()
            lastNameTextField.becomeFirstResponder()
            
        case lastNameTextField:
            lastNameTextField.resignFirstResponder()
            dniTextField.becomeFirstResponder()
            
        case dniTextField:
            dniTextField.resignFirstResponder()
            birthDatePicker.becomeFirstResponder()
        default:
            break
        }
        return false
    }
}
