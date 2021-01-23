//
//  SearchCityViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 23/01/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import UIKit

class SearchCityViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - Properties
    private var trips: [Trip] = []
    var originCity: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ServiceManager.sharedInstance.getTrips(from: originCity,
                                               to: "Cordoba") { (trips) in
            
            self.trips = trips
            
        } failureCallback: { (message) in
            
        }
    }

}


// MARK: - TextfieldDelegate
extension SearchCityViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}
