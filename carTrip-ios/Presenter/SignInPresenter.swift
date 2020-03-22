//
//  SignInPresenter.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 17/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation

protocol SignInPresenterDelegate: BasePresenterDelegate {
    
}


class SignInPresenter<T: SignInPresenterDelegate>: BasePresenter<T> {
    
    var email: String?
    var password: String?
    
    func postLogIn() {
            if let us = email, let pwd = password {
            UserManager.instance.postLogin(user: us, password: pwd)
        }
    }
}
