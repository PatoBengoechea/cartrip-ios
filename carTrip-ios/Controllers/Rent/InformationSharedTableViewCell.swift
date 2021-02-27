//
//  InformationSharedTableViewCell.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 08/12/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit
import MapKit

class InformationSharedTableViewCell: UITableViewCell {
    
    enum InformationType {
        case user, fromLocation
    }
    
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var informationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        informationLabel.numberOfLines = 0
        informationLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUpForInfo() {
        informationLabel.set(font: .gothamRoundedMedium(14), color: .blueCar)
        informationLabel.text = "Otros pasajeros se podran unir a tu viaje una vez que realices el alquiler"
    }
    
    func setUpForLocation(_ car: CarForRoadViewModel ) {
        informationLabel.set(font: .gothamRoundedBold(18), color: .blueCar)
        informationLabel.text = "\(R.string.localizable.from()) \(car.locationAddres)"
    }
}
