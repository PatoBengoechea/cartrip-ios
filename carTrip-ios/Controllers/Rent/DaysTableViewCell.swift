//
//  DaysTableViewCell.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 21/09/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

class DaysTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var resultTextfield: CarTripTextField!
    
    // MARK: - Properties
    weak var delegate: RentDelegate?
    var days: Int = 1 { didSet {
        delegate?.howManyDays = days
        }}
    var inputDays: Int = 1

    // MARK: - Override Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        
        customize()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Functions
    func setUp(delegate: RentDelegate, initialDays: Int) {
        self.delegate = delegate
        resultTextfield.text = "\(initialDays)"
    }
    
    // MARK: - Private Functions
    private func customize() {
        descriptionLabel.set(font: .gothamRoundedMedium(14), color: .blueCar)
        descriptionLabel.text = R.string.localizable.howManyDaysDoYouNeedTheCar()
        descriptionLabel.numberOfLines = 2
        descriptionLabel.adjustsFontSizeToFitWidth = true
        
        resultTextfield.textAlignment = .center
        addToolbarToTextField()
        
        resultTextfield.delegate = self
    }
    
    private func addToolbarToTextField() {
        let bar = UIToolbar()
        let button = UIBarButtonItem(title: R.string.localizable.dismiss(), style: .plain, target: self, action: #selector(dismissKeyboard))
        bar.items = [button]
        bar.sizeToFit()
        resultTextfield.inputAccessoryView = bar
    }
    
    // MARK: - OBJC Functions
    @objc func dismissKeyboard() {
        resultTextfield.resignFirstResponder()
    }

}

// MARK: - TextField Delegate
extension DaysTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text ?? ""
        let newText = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        
        inputDays = Int(newText) ?? 0
        
        if inputDays > 30 {
            return false
        } else {
            days = inputDays
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, let days = Int(text) {
            if days > 30 {
                return true
            }
        }
        return false
    }
}
