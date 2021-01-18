//
//  PriceTableViewCell.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 17/10/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

class PriceTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var unitPriceTitleLabel: UILabel!
    @IBOutlet weak var unitPriceValueLabel: UILabel!
    @IBOutlet weak var totalPriceTitleLabel: UILabel!
    @IBOutlet weak var totalPriceValueLabel: UILabel!

    // MARK: - Properties
    weak var delegate: RentDelegate?
    
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
    func setUp(type: TypeCarViewModel?, days: Int, delegate: RentDelegate) {
        self.delegate = delegate
        unitPriceValueLabel.text = type?.prizeRentUI ?? "-"
        totalPriceValueLabel.text = type?.getRentPricePerDays(days: days) ?? "-"
    }
    
    func setUpLoading() {
        
    }
    
    // MARK: - Private Functions
    private func customize() {
        unitPriceTitleLabel.set(font: .gothamRoundedMedium(14), color: .blueCar)
        unitPriceTitleLabel.text = R.string.localizable.pricePerDay()
        
        unitPriceValueLabel.set(font: .gothamRoundedMedium(14), color: .blueCar)
        unitPriceValueLabel.text = ""
        
        totalPriceTitleLabel.set(font: .gothamRoundedMedium(14), color: .blueCar)
        totalPriceTitleLabel.text = R.string.localizable.totalPrice()
        
        totalPriceValueLabel.set(font: .gothamRoundedMedium(14), color: .blueCar)
        totalPriceValueLabel.text = ""
    }

}
