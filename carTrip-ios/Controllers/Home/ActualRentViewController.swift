//
//  ActualRentViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 07/12/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

class ActualRentViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var finishTrip: UIButton!
    
    var actualTrip: Trip?

    override func viewDidLoad() {
        super.viewDidLoad()

        customize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUp()
    }

    
    private func customize() {
        titleLabel.set(font: .gothamRoundedBold(20), color: .blueCar)
        titleLabel.textAlignment = .center
        
        carLabel.set(font: .gothamRoundedMedium(18), color: .blueCar)
        carLabel.textAlignment = .center
        
    }

    private func setUp() {
        titleLabel.text = R.string.localizable.actualTrip()
        
        carLabel.text = "\(actualTrip?.carForRoad.car?.brand ?? "") \(actualTrip?.carForRoad.car?.name ?? "")"
        
        carImageView.setImage(image: actualTrip?.carForRoad.car?.img_path ?? "")
    }

}
