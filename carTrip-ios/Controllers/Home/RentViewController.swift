//
//  RentViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 09/09/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

class RentViewController: UIViewController {
    
    // MARK: - @IBOutlet
    

    // MARK: - Properties
    var currentCar: CarForRoadViewModel!
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = R.string.localizable.rentYourCar()
    }

}
