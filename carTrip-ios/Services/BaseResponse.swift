//
//  BaseResponse.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 17/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class BaseResponse {
    // MARK: - Properties
    var status: Bool
    var data: JSON?
    var message = "Hubo un error en la conexion"
    
    // MARK: - Functions
    init() {
        status = false
        data = nil
        message = "Hubo un error en la conexion"
    }
    
    func create(response: AFDataResponse<Any>) -> Self {
        if let statusCode = response.response?.statusCode, statusCode == 200 {
            if let value = response.data {
                status = true
                data = JSON(value)["data"]
                message = ""
            } else {
                status = false
                data = nil
                if let value = response.data {
                    message = JSON(value)["message"].stringValue
                }
            }
        } else {
            status = false
            data = nil
            if let value = response.data {
                message = JSON(value)["message"].stringValue
            }
        }
        return self
    }
}
