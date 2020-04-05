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
        struct Static { static let instance = ServiceManager()}
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
                        let cars = CarForRoad.parse(data: data)
                        succesCallback(cars)
                    } else {
                        failureCallback(response.message)
                    }
        }
    }
    
}
