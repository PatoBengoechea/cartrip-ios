//
//  SignInPresenter.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 17/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation

protocol SignInPresenterDelegate: BasePresenterDelegate {
    func onSuccesfullLogin()
}


class SignInPresenter<T: SignInPresenterDelegate>: BasePresenter<T> {
    
    var email: String?
    var password: String?
    
    func postLogIn() {
            if let us = email, let pwd = password {
                UserManager.sharedInstance.postLogin(user: us, password: pwd, delegate: self)
        }
    }
}

// MARK: - User Manager Delegate
extension SignInPresenter: UserManagerDelegate {
    func onRegister() {
        
    }
    
    func onLogin(user: User) {
        delegate?.onSuccesfullLogin()
    }
    
    func onInitService() {
        delegate?.startLoading()
    }
    
    func onFinishedService() {
        delegate?.finishedLoading()
    }
    
    func onError(_ message: String) {
        
    }
    
    
}
