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
        Alamofire.request(url,
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
}
