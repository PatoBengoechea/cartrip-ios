//
//  PersonalDataRegisterViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 17/06/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit
import CDAlertView

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
        
        nameTextField.carTripRadius()
        lastNameTextField.carTripRadius()
        dniTextField.carTripRadius()
        birthDateTextField.carTripRadius()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? LicenseViewController {
            dest.rootDelegate = rootDelegate
        }
    }
    
    // MARK: - Private Functions
    private func customize() {
        topView.backgroundColor = .white
        logoImageView.image = R.image.freeLogo()
        
        bottomView.backgroundColor = .blueCar
        
        nameTextField.placeholder = R.string.localizable.name()
        nameTextField.font = .gothamRoundedMedium(14)
        nameTextField.backgroundColor = .white
        
        lastNameTextField.placeholder = R.string.localizable.lastName()
        lastNameTextField.font = .gothamRoundedMedium(14)
        lastNameTextField.backgroundColor = .white
        
        dniTextField.placeholder = R.string.localizable.dnI()
        dniTextField.font = .gothamRoundedMedium(14)
        dniTextField.backgroundColor = .white
        
        birthDateTextField.placeholder = R.string.localizable.birthdate()
        birthDateTextField.font = .gothamRoundedMedium(14)
        birthDateTextField.backgroundColor = .white
        
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
        if nameTextField.text?.isEmpty ?? true || lastNameTextField.text?.isEmpty ?? true || dniTextField.text?.isEmpty ?? true || birthDateTextField.text?.isEmpty ?? true {
            return
        }
        if presenter?.isUser18YearOld() ?? false {
            performSegue(withIdentifier: R.segue.personalDataRegisterViewController.goToAddLicense, sender: nil)
        } else {
            let alert = CDAlertView(title: R.string.localizable.youCouldnTBeRegistered(), message: R.string.localizable.youMustBeGratherThan18YearsOldToBeRegistered(), type: .error)
            alert.autoHideTime = 3
            alert.show()
        }
    }
    
    private func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        datePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        let doneButton = UIBarButtonItem(title: R.string.localizable.done(), style: UIBarButtonItem.Style.done, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: R.string.localizable.cancel(), style: UIBarButtonItem.Style.done, target: self, action: #selector(cancelDatePicker))
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
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        birthDateTextField.text = formatter.string(from: picker.date)
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
