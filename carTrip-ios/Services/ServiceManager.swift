//
//  ServiceManager.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 17/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServiceManager {
    
    class var sharedInstance: ServiceManager {
        struct Static {
            static let instance = ServiceManager()}
        return Static.instance
    }
    
    func getLogin(email: String, password: String, succesCallback: @escaping (User)->(), failureCallback: @escaping (String)->()) {
        let url = PathBuilder.sharedInstance.getLogin()
        let body = BodyBuilder.postLogUser(email: email, password: password)
        AF.request(url,
                          method: .post,
                          parameters: body,
                          encoding: JSONEncoding.default,
                          headers: nil).responseJSON { (dataResponse) in
                            let response = BaseResponse().create(response: dataResponse)
                            if response.status, let data = response.data {
                                let user = User(data: data)
                                succesCallback(user)
                            } else {
                                print(response.message)
                                failureCallback(response.message)
                            }
        }
    }
    
    func getCarForRoad(succesCallback: @escaping ([CarForRoad])-> Void, failureCallback: @escaping (String)-> Void) {
        let url = PathBuilder.sharedInstance.getCarsForRoad()
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil,
                   interceptor: nil).responseJSON { (serviceResponse) in
                    let response = BaseResponse().create(response: serviceResponse)
                    if response.status, let data = response.data {
                        let cars = CarForRoad.parse(data: data["cars"].array ?? [])
                        succesCallback(cars)
                    } else {
                        failureCallback(response.message)
                    }
        }
    }
    
    func registerUser(user: UserInputModel, successCallback: @escaping ()-> Void, failureCallback: @escaping (String) -> Void) {
        let url = PathBuilder.sharedInstance.registerUser()
        let body = BodyBuilder.registerUser(user: user)
        Session.default.request(url,
                                method: .post,
                                parameters: body).responseJSON { (serviceResponse) in
                                    let response = BaseResponse().create(response: serviceResponse)
                                    if response.status, let _ = response.data {
                                        successCallback()
                                    } else {
                                        failureCallback(response.message)
                                    }
        }
    }
    
    func getCarForRoad(id: Int, successCallback: @escaping (CarForRoad) -> Void, failureCallback: @escaping (String) -> Void) {
        let url = PathBuilder.sharedInstance.getCarForRoad(id: id)
        Session.default.request(url,
                                method: .get,
                                encoding: JSONEncoding.default).responseJSON { (serviceResponse) in
                                    let response = BaseResponse().create(response: serviceResponse)
                                    if response.status, let data = response.data {
                                        let car = CarForRoad(withJSON: data["car"])
                                        successCallback(car)
                                    } else {
                                        failureCallback(response.message)
                                    }
        }
    }
    
    func postRentCar(dateInit: Date, dateFinish: Date, idCarForRoad: Int, successCallback: @escaping () -> Void, failureCallback: @escaping (String) -> Void) {
        let url = PathBuilder.sharedInstance.postRentCar(shared: false)
        let body = BodyBuilder.postRentCar(dateInit: dateInit, dateFinish: dateFinish, idCarForRoad: idCarForRoad)
        AF.request(url,
                   method: .post,
                   parameters: body,
                   encoding: JSONEncoding.default).responseJSON { (serviceResponse) in
                    let response = BaseResponse().create(response: serviceResponse)
                    if response.status, let _ = response.data {
                        successCallback()
                    } else {
                        failureCallback(response.message)
                    }
                   }
    }
    
    func getTrips(id: Int, successCallback: @escaping ([Trip]) -> Void, failureCallback: @escaping (String) -> Void) {
        let url = PathBuilder.sharedInstance.getTrips(id: id)
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default).responseJSON { (serviceResponse) in
                    let response = BaseResponse().create(response: serviceResponse)
                    if response.status, let data = response.data {
                        successCallback(Trip.parse(jsonArray: data["data"].arrayValue))
                    } else {
                        failureCallback(response.message)
                    }
                   }
    }
    
    
    func getActualTrip(id: String, successCallback: @escaping (Trip?) -> Void, failureCallback: @escaping (String) -> Void) {
        let url = PathBuilder.sharedInstance.getActualTrip(id: id)
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default).responseJSON { (serviceResponse) in
                    let response = BaseResponse().create(response: serviceResponse)
                    if response.status, let data = response.data {
                        if let noTrip = data["noTrip"].bool {
                            successCallback(nil)
                        } else {
                            successCallback(Trip(from: data["trip"]))
                        }
                    } else {
                        failureCallback(response.message)
                    }
                   }
    }
    
}
