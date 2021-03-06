//
//  PathBuilder.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 17/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation

class PathBuilder  {
    let url = "http://localhost:3000"
    
    
    class var sharedInstance: PathBuilder {
        struct Static {
            static let instance = PathBuilder()
        }
        return Static.instance
    }
    
    
    func getLogin() -> String {
        return "\(url)/login"
    }
    
    func getCarsForRoad() -> String {
        let id = UserDefaults.standard.string(forKey: "idUser") ?? "0"
        return "\(url)/carForRoad/user/\(id)"
    }
    
    func registerUser() -> String {
        return "\(url)/user/register"
    }
    
    func getCarForRoad(id: Int) -> String {
        return "\(url)/carForRoad/\(id)"
    }
    
    func postRentCar(shared: Bool) -> String {
        if shared {
            return "\(url)/rentcarshared"
        } else {
            return "\(url)/rentcar"
        }
    }
    
    func getTrips(id: Int) -> String {
        return "\(url)/trips/\(id)"
    }
    
    func getActualTrip(id: String) -> String {
        return "\(url)/trip/\(id)"
    }
    
    func getPlaces(name: String) -> String {
        return "\(url)/place/\(name.lowercased())"
    }
    
    func getLicense(id: String) -> String {
        return "\(url)/user/license/\(id)"
    }
    
    func getTripsFromTo(from city: String) -> String {
        return "\(url)/trip/from/\(city)"
    }
    
    func postCreditCard() -> String {
        return "\(url)/creditcard"
    }
    
    func getAllCreditCards(id: String) -> String {
        return "\(url)/creditcards/\(id)"
    }
    
    func getOneCreditCard(id: String) -> String {
        return "\(url)/creditcard/\(id)"
    }
    
    func postLicense() -> String {
        return "\(url)/user/license"
    }
    
    func postAddAsPassenger() -> String {
        return "\(url)/trip/passenger"
    }
}
