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
        dict["path"] = user.licensePath
        
        return dict
    }
    
    static func postRentCar(input: TripInputModel) -> [String: Any] {
        var dict = [String: Any]()
        dict["dateInit"] = input.dateInit
        dict["dateEnd"] = input.dateFinish
        dict["idCarForRoad"] = input.idCarForRoad
        dict["owner"] = input.owner
        dict["latitudeOrigin"] = input.latitudeOrigin
        dict["longitudeOrigin"] = input.longitudeOrigin
        dict["idPlace"] = input.idPlaceGivenBack
        dict["shared"] = input.shared
        dict["idCreditCard"] = input.idCreditCard
        dict["amount"] = input.amount
        return dict
    }
    
    static func postCreditCard(input: CreditCardInputModel) -> [String: Any] {
        var dict = [String: Any]()
        dict["creditCardNumber"] = input.number
        dict["holderName"] = input.holderName
        dict["monthExpiration"] = input.monthExpiration
        dict["yearExpiration"] = input.yearExpiration
        dict["ccv"] = input.ccv
        dict["idUser"] = input.idUser
        
        return dict
    }
    
    static func postLicense(path: String) -> [String: Any] {
        var dict = [String: Any]()
        dict["idUser"] = UserDefaults.standard.string(forKey: "idUser") ?? 0
        dict["path"] = path
        
        return dict
    }
}
