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
        return "\(url)/carForRoad"
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
}
