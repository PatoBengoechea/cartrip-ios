//
//  UserManager.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 17/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation

class UserManager {
    
    class var instance: UserManager {
        struct Static {
            static let instance = UserManager()
        }
        return Static.instance
    }
    
    func postLogin(user: String, password: String) {
        ServiceManager.sharedInstance.getLogin(email: user, password: password, succesCallback: {
            
        }) { (message) in
            print(message)
        }
    }
}
