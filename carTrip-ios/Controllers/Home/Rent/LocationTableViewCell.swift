//
//  LocationTableViewCell.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 08/12/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

protocol CityEnteredDelegate: NSObjectProtocol {
    func onChangeCity(city: String)
    func onContinue()
}

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    
    weak var delegate: CityEnteredDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityTextField.delegate = self
        customize()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(delegate: CityEnteredDelegate) {
        self.delegate = delegate
    }
    
    private func customize() {
        locationLabel.set(font: .gothamRoundedMedium(12), color: .blueCar)
        locationLabel.numberOfLines = 0
        locationLabel.text = R.string.localizable.enterACityAndWeWillProvideYouThePlacesToReturnTheCar()
    }

}

// MARK: - Text field delegate
extension LocationTableViewCell: UITextFieldDelegate  {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        delegate?.onChangeCity(city: updatedString ?? "")
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.onContinue()
        
        return true
    }
}
