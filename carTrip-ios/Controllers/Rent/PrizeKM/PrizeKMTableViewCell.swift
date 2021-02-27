//
//  PrizeKMTableViewCell.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 26/02/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import UIKit

class PrizeKMTableViewCell: UITableViewCell {
    
    @IBOutlet weak var kilometerLabel: UILabel!
    @IBOutlet weak var prizeKMLabel: UILabel!
    @IBOutlet weak var totalPrizeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        customize()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(kilometers: Int, prizeKM: Int) {
        kilometerLabel.text = "Cantidad de kilometros: \(kilometers)"
        prizeKMLabel.text = "Precio del kilometro: $\(prizeKM)"
        totalPrizeLabel.text = "Precio total: $\(kilometers*prizeKM)"
    }

    
    private func customize() {
        kilometerLabel.set(font: .gothamRoundedMedium(14), color: .blueCar)
        prizeKMLabel.set(font: .gothamRoundedMedium(14), color: .blueCar)
        totalPrizeLabel.set(font: .gothamRoundedMedium(14), color: .blueCar)
    }
}
