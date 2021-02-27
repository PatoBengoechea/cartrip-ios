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
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var passengerTitle: UILabel!
    @IBOutlet weak var passengetStackView: UIStackView!
    @IBOutlet weak var finishTrip: UIButton!
    
    var actualTrip: Trip?

    override func viewDidLoad() {
        super.viewDidLoad()

        finishTrip.isHidden = true
        customize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUp()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        finishTrip.setCornerRadius(cornerRadius: 10)
    }

    
    private func customize() {
        titleLabel.set(font: .gothamRoundedBold(18), color: .blueCar)
        titleLabel.textAlignment = .center
        
        carLabel.set(font: .gothamRoundedMedium(16), color: .blueCar)
        carLabel.textAlignment = .center
        
        fromLabel.set(font: .gothamRoundedMedium(16), color: .blueCar)
        fromLabel.numberOfLines = 2
        fromLabel.text = ""
        
        toLabel.set(font: .gothamRoundedMedium(16), color: .blueCar)
        toLabel.numberOfLines = 2
        toLabel.text = ""
        
        passengerTitle.set(font: .gothamRoundedBold(16), color: .blueCar)
        passengetStackView.alignment = .center
        passengetStackView.distribution = .equalCentering
        
        finishTrip.setTitle("Cancelar viaje", for: .normal)
        finishTrip.backgroundColor = .red
        finishTrip.setTitleColor(.white, for: .normal)
        
    }

    private func setUp() {
        titleLabel.text = R.string.localizable.actualTrip()
        
        carLabel.text = "\(actualTrip?.carForRoad.car?.brand ?? "") \(actualTrip?.carForRoad.car?.name ?? "")"
        
        

            
        carImageView.setImage(image: actualTrip?.carForRoad.car?.img_path ?? "")
        
        passengerTitle.text = R.string.localizable.passengers() + ":"
        
        let latitude = actualTrip?.carForRoad.latitude ?? "0.0"
        let longitude = actualTrip?.carForRoad.longitude ?? "0.0"

        if actualTrip?.shared ?? false {
            
            Helper.addresFrom(latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0) { (addres) -> (Void) in
                self.fromLabel.text = "\(R.string.localizable.from()): \(addres)"
            }
            
            Helper.addresFrom(latitude: actualTrip?.destinyPlace.latitude ?? 0.0, longitude: actualTrip?.destinyPlace.longitude ?? 0.0) { (addres) -> (Void) in
                self.toLabel.text = "\(R.string.localizable.to()): \(addres)"
            }
            
            
            actualTrip?.passengers.forEach {
                let label = UILabel()
                label.set(font: .gothamRoundedMedium(14), color: .blueCar)
                label.text = $0.nameUser! + " " + $0.lastNameUser!
                passengetStackView.addArrangedSubview(label)
            }
            if actualTrip?.passengers.isEmpty ?? true{
                let label = UILabel()
                label.set(font: .gothamRoundedMedium(14), color: .blueCar)
                label.numberOfLines = 2
                label.text = R.string.localizable.theTripHavenTGotPassengersYet()
                passengetStackView.addArrangedSubview(label)
            }
        } else {
            Helper.addresFrom(latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0) { (addres) -> (Void) in
                self.fromLabel.text = "Debes retirar el vehiculo en: \(addres). Y devolverlo en el mismo lugar"
            }
            
            toLabel.text = "Tienes hasta el día: \(DateHelper.dateLong(fromDateWithFullTime: actualTrip?.dateEnd ?? ""))"
            passengerTitle.text = ""
        }
    
    }

}
