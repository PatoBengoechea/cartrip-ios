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
    @IBOutlet weak var nameTextField: CarTripTextField!
    @IBOutlet weak var lastNameTextField: CarTripTextField!
    @IBOutlet weak var dniTextField: CarTripTextField!
    @IBOutlet weak var birthDateTextField: CarTripTextField!
    @IBOutlet weak var haveAccountView: UIControl!
    @IBOutlet weak var haveAccountLabel: UILabel!

    // MARK: - Properties
    let datePicker = UIDatePicker()
    weak var rootDelegate: RootViewControllerDelegate?
    
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
        
        nameTextField.roundCorners(radius: 20, corners: .allCorners)
        lastNameTextField.roundCorners(radius: 20, corners: .allCorners)
        dniTextField.roundCorners(radius: 20, corners: .allCorners)
        birthDateTextField.roundCorners(radius: 20, corners: .allCorners)
        
    }
    
    override func keyboardWillHide(_ keyboardHeight: CGFloat) {
        
    }
    
    override func keyboardWillShow(_ keyboardHeight: CGFloat) {
        
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
        
        birthDateTextField.placeholder = R.string.localizable.birthdate()
        birthDateTextField.font = .gothamRoundedMedium(14)
        
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
    
    private func checkFormFormForRegister() {
        presenter?.registerUser()
    }
    
    private func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.done, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        // add toolbar to textField
        birthDateTextField.inputAccessoryView = toolbar
        // add datepicker to textField
        birthDateTextField.inputView = datePicker
        
    }
    
    @objc func donedatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        birthDateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        presenter?.setBirthDate(datePicker.date)
        checkFormFormForRegister()
        
    }
    
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
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
            birthDateTextField.becomeFirstResponder()
        default:
            break
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case birthDateTextField:
            print("Date")
            showDatePicker()
        default:
            break
        }
    }
}

// MARK: - Auth Delegate
extension PersonalDataRegisterViewController: RegisterPresenterDelegate {
    func onRegister() {
        rootDelegate?.showHome()
    }
    
    
}
