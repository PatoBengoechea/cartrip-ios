//
//  TripFromToTableViewCell.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 23/01/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import UIKit

class TripFromToTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var passengerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        customize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        carImageView.roundCorners(radius: carImageView.frame.width/2, corners: .allCorners)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(trip: Trip) {
        carImageView.setImage(image: trip.carForRoad.car?.img_path ?? "")
        
        carLabel.text = "\(trip.carForRoad.car?.brand ?? "") \(trip.carForRoad.car?.name ?? "")"
        
        fromLabel.text = "\(R.string.localizable.from()): \(trip.originPlace.cityName)"
        
        toLabel.text = "\(R.string.localizable.to()): \(trip.destinyPlace.cityName)"
        
        let seats = trip.carForRoad.car?.type?.capacity
        let passengers = trip.passengers.count + 1
        
        let availableSeats = (seats! - passengers)
        
        passengerLabel.text = "\(R.string.localizable.seatsAvailable())\(availableSeats)"
        
        let date = DateParsed(trip.dateInit, format: .dateWithFullTime)
        dateLabel.text = date?.dateLong()
    }

    private func customize() {
        carImageView.contentMode = .scaleAspectFill
        
        fromLabel.font = .gothamRoundedBold(14)
        fromLabel.textColor = .blueCar
        
        toLabel.font = .gothamRoundedBold(14)
        toLabel.textColor = .blueCar
        
        carLabel.font = .gothamRoundedMedium(13)
        carLabel.textColor = .blueCar
        
        passengerLabel.font = .gothamRoundedMedium(13)
        passengerLabel.textColor = .blueCar
        
        dateLabel.font = .gothamRoundedMedium(13)
        dateLabel.textColor = .blueCar
    }
}
