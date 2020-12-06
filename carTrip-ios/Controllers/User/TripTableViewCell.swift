//
//  TripTableViewCell.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 06/12/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

class TripTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        customize()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        carImageView.roundCorners(radius: carImageView.frame.width/2, corners: .allCorners)
    }
    
    func setUp(trip: Trip) {
        carImageView.setImage(image: trip.carForRoad.car?.img_path ?? "")
        carLabel.text = "\(trip.carForRoad.car?.brand ?? "") \(trip.carForRoad.car?.name ?? "")"
        let date = DateParsed(trip.dateInit, format: .dateWithFullTime)
        dateLabel.text = date?.dateLong()
    }
    
    private func customize() {
        carLabel.font = .gothamRoundedBold(14)
        carLabel.textColor = .blueCar
        
        dateLabel.font = .gothamRoundedMedium(13)
        carLabel.textColor = .blueCar
    }

}
