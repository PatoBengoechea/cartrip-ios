//
//  DateTableViewCell.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 28/02/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import UIKit

protocol DateSelectedProtocol: AnyObject {
    func onDateSelected(date: Date)
}

class DateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    

    let datePicker = UIDatePicker()
    weak var delegate: DateSelectedProtocol?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateTextField.delegate = self
        dateTextField.font = .gothamRoundedMedium(14)
        dateTextField.textAlignment = .right
        dateLabel.set(font: .gothamRoundedMedium(14), color: .blueCar)
        datePickerChanged(picker: datePicker)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(delegate: DateSelectedProtocol) {
        self.delegate = delegate
    }
    
    private func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .dateAndTime
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        let calendar = Calendar(identifier: .gregorian)
        var comps = DateComponents()
        comps.month = 1
        let maxDate = calendar.date(byAdding: comps, to: Date())
        datePicker.maximumDate = maxDate
        datePicker.minimumDate = Date()
        
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
        dateTextField.inputAccessoryView = toolbar
        // add datepicker to textField
        dateTextField.inputView = datePicker
        
    }
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        let date = picker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = components.hour ?? 0
        let minutes = components.minute ?? 0
        
        let hourAndMinutes = "\(hour):\(minutes)"
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy \(hourAndMinutes)"
        dateTextField.text = formatter.string(from: picker.date)
    }
    
    @objc func donedatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = formatter.string(from: datePicker.date)
        delegate?.onDateSelected(date: datePicker.date)
        self.endEditing(true)
        
    }
    
    @objc func cancelDatePicker() {
        self.endEditing(true)
    }

}

extension DateTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case dateTextField:
            showDatePicker()
        default:
            break
        }
    }
}
