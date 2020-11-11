//
//  ShareTableViewCell.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 21/09/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

class ShareTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var switchView: UISwitch!
    
    // MARK: - Properties
    weak var delegate: RentDelegate?
    
    @IBAction func toggleSwitch() {
        delegate?.shareCar = switchView.isOn
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        customize()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Functions
    func setUp(delegate: RentDelegate) {
        self.delegate = delegate
    }

    // MARK: - Private Functions
    private func customize() {
        descriptionLabel.set(font: .gothamRoundedMedium(14), color: .blueCar)
        descriptionLabel.text = R.string.localizable.doYouWantOtherPeopleJoinToYourCar()
        descriptionLabel.numberOfLines = 2
        descriptionLabel.adjustsFontSizeToFitWidth = true
        
        switchView.isOn = false
    }
    
    
}
