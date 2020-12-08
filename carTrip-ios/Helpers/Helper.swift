//
//  Helper.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 09/06/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation
import MapKit

class Helper {
    static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func addresFrom(latitude: Double, longitude: Double, handler: @escaping (String) -> (Void)) {
        let geoCoder = CLGeocoder()
        let lat = CLLocationDegrees(latitude)
        let long = CLLocationDegrees(longitude)
        let clLocation = CLLocation(latitude: lat, longitude: long)
        geoCoder.reverseGeocodeLocation(clLocation) { (placermarks, error) in
            guard let placeMark = placermarks?.first else { return }
            let addres = "\(placeMark.name ?? ""), \(placeMark.locality ?? "")"
            handler(addres)
        }
    }
}
