//
//  UserManager.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 17/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation

protocol UserManagerDelegate: BaseManagerDelegate {
    func onLogin(user: User)
    func onRegister()
}

class UserManager: BaseManager {
    
    class var sharedInstance: UserManager {
        struct Static {
            static let instance = UserManager()
        }
        return Static.instance
    }
    
    
    func postLogin(user: String, password: String, delegate: UserManagerDelegate) {
        delegate.onInitService()
        ServiceManager.sharedInstance.getLogin(email: user, password: password, succesCallback: { user in
            DefaultManager.set(value: user.idUser, forKey: .idUser)
            delegate.onLogin(user: user)
            delegate.onFinishedService()
        }) { (message) in
            delegate.onError(message)
            delegate.onFinishedService()
        }
    }
    
    func registerUser(user: UserInputModel, delegate: UserManagerDelegate) {
        delegate.onInitService()
        ServiceManager.sharedInstance.registerUser(user: user, successCallback: {
            delegate.onFinishedService()
            delegate.onRegister()
        }, failureCallback: { message in
            delegate.onFinishedService()
            delegate.onError(message)
        })
    }
    
    
    func isLogged() -> Bool {
        guard let _ = UserDefaults.standard.string(forKey: "idUser") else { return false}
        return true
        
    }
}
