//
//  UserManager.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 17/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation
import RealmSwift

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
    
    var realm = try? Realm()
    
    func postLogin(user: String, password: String, delegate: UserManagerDelegate) {
        delegate.onInitService()
        ServiceManager.sharedInstance.getLogin(email: user, password: password, succesCallback: { user in
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
    
    func save(_ user: User) {
        realm?.add(user)
    }
    
    func isLogged() -> Bool {
        let user =  realm?.objects(User.self)
        return user != nil
    }
}
