//
//  RegisterPresenter.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 17/06/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation

protocol RegisterPresenterDelegate: BasePresenterDelegate {
    func onLogin()
    func onRegister()
}

extension BasePresenterDelegate {
    func onLogin() { }
    func onRegister() { }
}

class RegisterPresenter<T: RegisterPresenterDelegate>: BasePresenter<T> {
    
    private var inputModel = UserInputModel()
    
    func setEmail(_ email: String?) {
        inputModel.email = email
    }
    
    func setPassword(_ password: String?) {
        inputModel.password = password
    }
    
    func setName(_ name: String?) {
        inputModel.name = name
    }
    
    func setLastName(_ lastName: String?) {
        inputModel.lastName = lastName
    }
    
    func setDNI(_ dni: String?) {
        inputModel.dni = dni
    }
    
    func setBirthDate(_ birthDate: Date) {
        inputModel.setBirthDate(date: birthDate)
    }
    
    func registerUser() {
        UserManager.sharedInstance.registerUser(user: inputModel, delegate: self)
    }
    
    func loginUser() {
        UserManager.sharedInstance.postLogin(user: inputModel.email ?? "", password: inputModel.password ?? "", delegate: self)
    }
}

// MARK: - User Manager Delegate
extension RegisterPresenter: UserManagerDelegate {
    func onLogin(user: User) {
        UserDefaults.standard.set(user.idUser, forKey: "idUser")
        UserDefaults.standard.set(user.nameUser, forKey: "name")
        UserDefaults.standard.set(user.lastNameUser, forKey: "lastName")
        delegate?.onLogin()
    }
    
    func onRegister() {
        delegate?.onRegister()
    }
    
    func onInitService() {
        delegate?.startLoading()
    }
    
    func onFinishedService() {
        delegate?.finishedLoading()
    }
    
    func onError(_ message: String) {
        delegate?.onError(message: message)
    }
    
    
}
