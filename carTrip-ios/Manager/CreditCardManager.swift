//
//  CreditCardManager.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 30/01/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import Foundation

protocol CreditCardManagerDelegate: BaseManagerDelegate {
    func cardAdded()
    func onGetCreditCards(cards: [CreditCard])
}

class CreditCardManager: BaseManager {

    static let shared = CreditCardManager()
    
    func postCreditCard(input: CreditCardInputModel, delegate: CreditCardManagerDelegate) {
        delegate.onInitService()
        ServiceManager.sharedInstance.addNewCard(inputModel: input) {
            delegate.onFinishedService()
            delegate.cardAdded()
        } failureCallback: { (message) in
            delegate.onFinishedService()
            delegate.onError(message)
        }
    }
    
    func getCreditCard(id: String, delegate: CreditCardManagerDelegate) {
        delegate.onInitService()
        ServiceManager.sharedInstance.getAllCreditCards(id: id) { cards in
            delegate.onFinishedService()
            delegate.onGetCreditCards(cards: cards)
        } failureCallback: { (message) in
            delegate.onFinishedService()
            delegate.onError(message)
        }
    }
}
