//
//  ListCarTableViewCell.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 18/01/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import UIKit

class ListCarTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var addresLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    // MARK: - Properties
    var carModel: CarForRoadViewModel!
    
    // MARK: - Override Functions
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

    // MARK: - Functions
    func setUp(car: CarForRoadViewModel) {
        carModel = car
        
        carImageView.setImage(image: carModel.car?.img_path ?? "")
        modelLabel.text = carModel.car?.fullName
        addresLabel.text = carModel.locationAddres
    }
    
    // MARK: - Private Functions
    private func customize() {
        carImageView.contentMode = .scaleAspectFill
        
        modelLabel.font = .gothamRoundedBold(14)
        modelLabel.textColor = .blueCar
        
        addresLabel.font = .gothamRoundedMedium(13)
        addresLabel.textColor = .blueCar
        
        distanceLabel.font = .gothamRoundedMedium(13)
        distanceLabel.textColor = .blueCar
    }
}
