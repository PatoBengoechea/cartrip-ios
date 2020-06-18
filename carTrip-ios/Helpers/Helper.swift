//
//  Helper.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 09/06/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation

class Helper {
    static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
