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
    
    static func registerUser(user: UserInputModel) -> [String: Any] {
        var dict = [String: Any]()
        dict["name"] = user.name
        dict["lastname"] = user.lastName
        dict["email"] = user.email
        dict["password"] = user.password
        dict["dni"] = user.dni
        dict["birthdate"] = user.birthDate
        
        return dict
    }
    
    static func postRentCar(dateInit: Date, dateFinish: Date, idCarForRoad: Int) -> [String: Any] {
        var dict = [String: Any]()
        dict["dateInit"] = dateInit.dateToString()
        dict["dateEnd"] = dateFinish.dateToString()
        dict["idCarForRoad"] = idCarForRoad
        return dict
    }
}
