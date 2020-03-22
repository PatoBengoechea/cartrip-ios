//
//  BodyBuilder.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 17/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation

class BodyBuilder  {
    static func postLogUser(email: String, password: String) -> [String: Any] {
        var dict = [String: Any]()
        dict["email"] = email
        dict["password"] = password
        return dict
    }
}