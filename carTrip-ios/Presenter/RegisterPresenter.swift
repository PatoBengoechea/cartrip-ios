//
//  RegisterPresenter.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 17/06/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation

protocol RegisterPresenterDelegate: BasePresenterDelegate {
    
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
        inputModel.birthdate = birthDate
    }
}
