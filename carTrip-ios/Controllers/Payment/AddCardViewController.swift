//
//  AddCardViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 30/01/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController {

    
    // MARK: - @IBOutlet
    @IBOutlet var ccView: CreditCardView!
    @IBOutlet weak var ccViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardFormView: UIView!
    @IBOutlet weak var cardHolderNameTextField: UITextField!
    @IBOutlet weak var cardHolderNameErrorLabel: UILabel!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardNumberErrorLabel: UILabel!
    @IBOutlet weak var expirationDateTextfield: UITextField!
    @IBOutlet weak var dateErrorLabel: UILabel!
    @IBOutlet weak var ccvCardTextField: UITextField!
    @IBOutlet weak var ccvErrorLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var buttonImage: UIImageView!
    @IBOutlet weak var saveCardButton: UIButton!

    // MARK: - Properties
    private var cardHolderName = ""
    private var month = ""
    private var year = ""
    private var cardNumber = ""
    private var ccvNumber = ""
    private var cardBrand: CardBrand = .undefined
    private var validCCNumber: Bool = false
    private var validExpirationDate: Bool = false
    private var validCCCcv: Bool = false
    private var validCardHolderName: Bool { return !(cardHolderNameTextField.text?.isEmpty ?? true)}
    private let generator = UIImpactFeedbackGenerator(style: .heavy)
    private let toolBar = UIToolbar()
    private let kAnimationDuration = 0.5
    private var saveCallback: (()->())?
    private var formBottomSpace: CGFloat { return self.view.frame.height - ccView.frame.height - cardFormView.frame.height }
    
    // MARK: - @IBAction
    @IBAction func handleTextField(_ textField: UITextField) {
        let inputText = textField.text ?? ""
        switch textField {
        case cardHolderNameTextField:
            handleCardHolder(text: inputText)
            
        case cardNumberTextField:
            handleCardNumber(text: inputText)
        
        case expirationDateTextfield:
            handleExpirationDate(text: inputText)
            
        case ccvCardTextField:
            handleCcvNumber(text: inputText)
            
        default:
            break
        }
        checkIfCreditCardIsValid()
    }
    
    @IBAction private func saveButtonTapped() {
        if validCCNumber, validExpirationDate, validCCCcv, validCardHolderName {
            saveCard()
        }
    }
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        customize()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customizeCreditCardView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
//    override func keyboardWillShow(_ keyboardHeight: CGFloat) {
//        /// If the keyboard is hiding the form, the credit card view goes up
//        let space: CGFloat = (formBottomSpace - (keyboardHeight + toolBar.frame.height))
//        if space < 0 {
//            self.ccViewTopConstraint.constant = space
//        }
//        self.view.layoutIfNeeded()
//    }
//
//    override func keyboardWillHide(_ keyboardHeight: CGFloat) {
//        self.ccViewTopConstraint.constant = 10
//        self.view.layoutIfNeeded()
//    }
    
    // MARK: - Functions
    func setSaveCallback(callback: @escaping (()->())) {
        saveCallback = callback
    }

    // MARK: - Private Functions
    private func handleCardHolder(text: String) {
        cardHolderName = text
        ccView.setFullName(name: cardHolderName)
        checkIfCardHolderNameIsEmpty()
    }
    
    private func handleCardNumber(text: String) {
        checkIfCardHolderNameIsEmpty()
        cardNumber = text
        cardBrand = CCHelper.cardType(number: text)
        ccView.setCardNumber(number: text)
        
//        ccView.setNewGradientColor(fromColor: CreditCardViewModel.getGradientFromColor(for: cardBrand), toColor: CreditCardViewModel.getGradientToColor(for: cardBrand))
        
        if cardBrand == .undefined {
            ccView.setCardImage(image: R.image.ccPlaceholder())
        } else {
            ccView.setCardImage(image: cardBrand.image)
        }
        hideCardNumberError(true)
        if CCHelper.luhnCheck(text), cardBrand != .undefined {
            validCCNumber = true
            expirationDateTextfield.becomeFirstResponder()
        } else if text.count > 15 {
            validCCNumber = false
            hideCardNumberError(false)
            generator.impactOccurred()
        } else {
            validCCNumber = false
        }
    }
    
    private func handleExpirationDate(text: String) {
        checkIfCardHolderNameIsEmpty()
        let subStrings = text.split(separator: "/")
        month = String(subStrings.first ?? "")
        if subStrings.count == 2 {
            year = String(subStrings.last ?? "")
        }
        
        if text.count == 5 {
            validExpirationDate = CCHelper.validateDate(expiryMonth: month, expiryYear: year)
        } else {
            validExpirationDate = false
        }
        ccView.setDate(date: text)
        if validExpirationDate {
            hideExpirationDateError(true)
            ccvCardTextField.becomeFirstResponder()
            validExpirationDate = true
        } else if text.count == 5 {
            hideExpirationDateError(false)
            generator.impactOccurred()
        }
    }
    
    private func handleCcvNumber(text: String) {
        ccvNumber = text
        
        if text.count == CCHelper.getMaxCCVLength(cardType: cardBrand) {
            validCCCcv = true
            if !validCardHolderName {
                hideCardHolderNameError(false)
                checkCCVLength()
                cardHolderNameTextField.becomeFirstResponder()
            } else {
                checkCCVLength()
                ccvCardTextField.resignFirstResponder()
            }
        } else {
            validCCCcv = false
        }
    }
    
    private func customize() {
        let kTextFieldFont = 14
        let kErrorLabelFont = 12
        let underlinedColor = UIColor.blueCar
        
//        navigationItem.setCenterTitle(R.localizable.addCreditCard(), color: UIColor.lightGray)
//        navigationItem.setBackMenuButton(viewController: self, color: UIColor.lightGray))
        
//        view.backgroundColor = CinemexColors.white(.cinemexBackgroundDarkGrayMain)
        cardFormView.backgroundColor = .clear
        
        ccView.disableRemoveButton()
        
        cardHolderNameTextField.font = .gothamRoundedMedium(kTextFieldFont)
        cardHolderNameTextField.attributedPlaceholder = NSAttributedString(string: R.localizable.nameAndLastname(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        cardHolderNameTextField.underlined(color: underlinedColor)
        cardHolderNameTextField.textColor = .blueCar
        cardHolderNameTextField.keyboardType = .alphabet
        cardHolderNameTextField.autocorrectionType = .no
        cardHolderNameTextField.autocapitalizationType = .words
        cardHolderNameTextField.text = ""
        cardHolderNameTextField.delegate = self
        
        cardHolderNameErrorLabel.set(font: UIFont.gothamRoundedMedium(kErrorLabelFont), color: UIColor.systemPink)
        cardHolderNameErrorLabel.alpha = 0
        cardHolderNameErrorLabel.text = R.localizable.errorInCardHolderName()
        
        cardNumberTextField.font = .gothamRoundedMedium(kTextFieldFont)
        cardNumberTextField.attributedPlaceholder = NSAttributedString(string: R.localizable.cardNumber(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        cardNumberTextField.underlined(color: underlinedColor)
        cardNumberTextField.textColor = .blueCar
        cardNumberTextField.keyboardType = .numberPad
        cardNumberTextField.text = ""
        cardNumberTextField.delegate = self
        
        cardNumberErrorLabel.set(font: .gothamRoundedMedium(kErrorLabelFont), color: UIColor.systemPink)
        cardNumberErrorLabel.alpha = 0
        cardNumberErrorLabel.text = R.localizable.errorInCCNumber()
        
        expirationDateTextfield.font = .gothamRoundedMedium(kTextFieldFont)
        expirationDateTextfield.attributedPlaceholder = NSAttributedString(string: R.localizable.mmyY(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        expirationDateTextfield.underlined(color: underlinedColor)
        expirationDateTextfield.textColor = .blueCar
        expirationDateTextfield.keyboardType = .numberPad
        expirationDateTextfield.text = ""
        expirationDateTextfield.delegate = self
        
        dateErrorLabel.set(font: .gothamRoundedMedium(kErrorLabelFont), color: UIColor.systemPink)
        dateErrorLabel.alpha = 0
        dateErrorLabel.text = R.localizable.errorInExpirationDate()
        
        ccvCardTextField.font = .gothamRoundedMedium(kTextFieldFont)
        ccvCardTextField.attributedPlaceholder = NSAttributedString(string: R.localizable.ccV(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        ccvCardTextField.underlined(color: underlinedColor)
        ccvCardTextField.textColor = .blueCar
        ccvCardTextField.keyboardType = .numberPad
        ccvCardTextField.text = ""
        ccvCardTextField.isSecureTextEntry = true
        ccvCardTextField.delegate = self
        
        ccvErrorLabel.set(font: .gothamRoundedMedium(kErrorLabelFont), color: .systemPink)
        ccvErrorLabel.alpha = 0
        ccvErrorLabel.text = R.localizable.errorInCCVCode()
        
        buttonView.backgroundColor = .lightGray
        saveCardButton.isEnabled = false
        saveCardButton.setTitle(R.localizable.save(), for: .normal)
        saveCardButton.setTitleColor(.white, for: .normal)
        
        customizeToolbar()
        
        ccView.gradientView.setupView(fromColor: UIColor.blueCar.withAlphaComponent(0.6), toColor: .blueCar)
        
        ccView.setRemoveCallback { [unowned self] in
            UIView.animate(withDuration: self.kAnimationDuration,
                              animations: {
                                self.cardHolderNameTextField.text = ""
                                self.cardHolderName = ""
                                
                                self.cardNumberTextField.text = ""
                                self.cardNumber = ""
                                self.validCCNumber = false
                                
                                self.expirationDateTextfield.text = ""
                                self.month = ""
                                self.year = ""
                                self.validExpirationDate = false
                                
                                self.ccvCardTextField.text = ""
                                self.validCCCcv = false
                                self.ccvNumber = ""
            }, completion: nil)
        }
    }
    
    private func customizeCreditCardView() {
        ccView.setCornerRadius(cornerRadius: 5)
        ccView.addShadow(color: .darkGray, radious: 5)
    }
    
    private func customizeToolbar() {
        toolBar.barStyle = .default
        let doneButton = UIBarButtonItem(title: R.string.localizable.ready(), style: .plain, target: self, action: #selector(acceptButtonTapped(_:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let nextButton = UIBarButtonItem(title: R.string.localizable.next(), style: .plain, target: self, action: #selector(nextButtonTapped(_:)))
        toolBar.setItems([doneButton, spaceButton, nextButton], animated: false)
        toolBar.sizeToFit()
        cardHolderNameTextField.inputAccessoryView = toolBar
        cardNumberTextField.inputAccessoryView = toolBar
        expirationDateTextfield.inputAccessoryView = toolBar
        ccvCardTextField.inputAccessoryView = toolBar
    }
    
    private func checkIfCreditCardIsValid() {
        if !(cardNumberTextField.text ?? "").isEmpty, !cardNumberTextField.isFirstResponder {
            validCCNumber = (cardNumber.count == CCHelper.getMaxNumberLength(cardType: cardBrand))
            hideCardNumberError(validCCNumber)
        }
        if !(ccvCardTextField.text ?? "").isEmpty, !ccvCardTextField.isFirstResponder {
            validCCCcv = (ccvNumber.count == CCHelper.getMaxCCVLength(cardType: cardBrand))
            checkCCVLength()
        }
        
        if validCCNumber, validExpirationDate, validCCCcv, validCardHolderName {
            saveCardButton.isEnabled = true
            saveCardButton.backgroundColor = .blueCar
            buttonView.backgroundColor = .blueCar
        } else {
            saveCardButton.backgroundColor = .lightGray
            buttonView.backgroundColor = .lightGray
            saveCardButton.isEnabled = false
        }
    }
    
    private func saveCard() {
        if let ccInputModel = mapCreditCard() {
            CreditCardManager.shared.postCreditCard(input: ccInputModel, delegate: self)
            
        } else {
//            let alert = CinemexDialog(title: R.localizable.errorSavingTheCreditCard(), message: R.localizable.pleaseTryAgain())
//            alert.present()
        }
    }
    
    func mapCreditCard() -> CreditCardInputModel? {
        guard let month = Int(month), let year = Int(year) else { return nil }
        return CreditCardInputModel(holder: cardHolderName, number: cardNumber, monthExpiration: month, yearExpiration: year, ccv: ccvNumber)
        
    }
    
    private func hideCardNumberError(_ show: Bool) {
        let alpha: CGFloat = show ? 0 : 1
        UIView.animate(withDuration: kAnimationDuration) {
            self.cardNumberErrorLabel.alpha = alpha
        }
    }
    
    private func hideExpirationDateError(_ show: Bool) {
        let alpha: CGFloat = show ? 0 : 1
        UIView.animate(withDuration: kAnimationDuration) {
            self.dateErrorLabel.alpha = alpha
        }
    }
    
    private func hideCCVError(_ show: Bool) {
        let alpha: CGFloat = show ? 0 : 1
        UIView.animate(withDuration: kAnimationDuration) {
            self.ccvErrorLabel.alpha = alpha
        }
    }
    
    private func hideCardHolderNameError(_ show: Bool) {
        let alpha: CGFloat = show ? 0 : 1
        UIView.animate(withDuration: kAnimationDuration) {
            self.cardHolderNameErrorLabel.alpha = alpha
        }
    }
    
    private func checkIfCardHolderNameIsEmpty() {
        if validCardHolderName {
            hideCardHolderNameError(true)
        } else {
            hideCardHolderNameError(false)
        }
    }
    
    private func checkCCVLength() {
        if validCCCcv {
            hideCCVError(true)
        } else {
            hideCCVError(false)
        }
    
    }
    
    // MARK: - @OBJC Functions
    @objc func acceptButtonTapped(_ sender: UITextField) {
        if cardHolderNameTextField.isFirstResponder {
            cardHolderNameTextField.resignFirstResponder()
        } else if cardNumberTextField.isFirstResponder {
            cardNumberTextField.resignFirstResponder()
        } else if expirationDateTextfield.isFirstResponder {
            expirationDateTextfield.resignFirstResponder()
        } else if ccvCardTextField.isFirstResponder {
            ccvCardTextField.resignFirstResponder()
            checkCCVLength()
        }
    }
    
    @objc func nextButtonTapped(_ sender: UITextField) {
        if cardHolderNameTextField.isFirstResponder {
            cardNumberTextField.becomeFirstResponder()
        } else if cardNumberTextField.isFirstResponder {
            expirationDateTextfield.becomeFirstResponder()
        } else if expirationDateTextfield.isFirstResponder {
            ccvCardTextField.becomeFirstResponder()
        } else if ccvCardTextField.isFirstResponder {
            ccvCardTextField.resignFirstResponder()
            checkCCVLength()
        }
    }


}

// MARK: - TextField Delegate
extension AddCardViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text ?? ""
        let newText = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        
        switch textField {
        case cardNumberTextField:
            return newText.count <= 19
            
        case expirationDateTextfield:
            if oldText.count == 2, !(string == "") {
                textField.text = "\(oldText)/"
            } else if oldText.count == 4, string == "" {
                textField.text?.removeLast()
            }
            return newText.count <= 5
            
        case ccvCardTextField:
            return newText.count <= CCHelper.getMaxCCVLength(cardType: cardBrand)
            
        default:
            break
        }
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case cardHolderNameTextField:
            cardNumberTextField.becomeFirstResponder()
        default:
            break
        }
        return true
    }
}

// MARK: - Manager delegate
extension AddCardViewController: CreditCardManagerDelegate {
    func cardAdded() {
        dismiss(animated: true, completion: {
            self.saveCallback?()
        })
    }
    
    func onGetCreditCards(cards: [CreditCard]) {
        
    }
    
    func onInitService() {
        Loader.showLoader()
    }
    
    func onFinishedService() {
        Loader.dismiss()
    }
    
    func onError(_ message: String) {
        
    }
    
    
}
