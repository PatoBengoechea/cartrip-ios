//
//  CreditCardHelper.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 30/01/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import Foundation
import UIKit

typealias CCHelper = CreditCardHelper

enum CardBrand {
    case visa, mastercard, discover, amex, dinners, carnet1, carnet2, carnet3, undefined
    static let allCreditCards: [CardBrand] = [.visa, .mastercard, .discover, .amex, .dinners, .carnet1, .carnet2, .carnet3]
    
    var regex: String {
        switch self {
        case .visa:
            return "^4\\d{3}[\\s-]?\\d{4}[\\s-]?\\d{4}[\\s-]?\\d{4}$"
        case .mastercard:
            return "^5[1-5]\\d{2}[\\s-]?\\d{4}[\\s-]?\\d{4}[\\s-]?\\d{4}$"
        case .discover:
            return "^6011[\\s-]?\\d{4}[\\s-]?\\d{4}[\\s-]?\\d{4}$"
        case .amex:
            return "^3[4,7]\\d{2}[\\s-]?\\d{6}[\\s-]?\\d{5}$"
        case .dinners:
            return "^3[0,6,8]\\d{12}$"
        case .carnet1:
            return "^506[2,3,4][\\s-]?\\d{4}[\\s-]?\\d{4}[\\s-]?\\d{4}$"
        case .carnet2:
            return "^28[\\s-]?\\d{14}$"
        case .carnet3:
            return "^6[0,2,3][\\s-]?\\d{14}$"
        default:
            return ""
        }
    }
    
    var image: UIImage? {
        switch self {
        case .visa:
            return R.image.visa()
        case .mastercard:
            return R.image.master()
        case .amex:
            return R.image.amex()
        case .carnet1, .carnet2, .carnet3:
            return R.image.carnet()
        case .undefined:
            return R.image.ccPlaceholder()
        default:
            return R.image.ccPlaceholder()
        }
    }

}


class CreditCardHelper: NSObject {
    
    static func getMaxNumberLength(cardType: CardBrand) -> Int {
        switch cardType {
        case .amex:
            return 15
        default:
            return 16
        }
    }
    
    static func getMaxCCVLength(cardType: CardBrand) -> Int {
        switch cardType {
        case .amex:
            return 4
        default:
            return 3
        }
    }
    
    static func validateDate(expiryMonth: String, expiryYear: String) -> Bool {
        guard let month = Int(expiryMonth) else { return false}
        guard let year = Int(expiryYear) else { return false}
        
        if month < 1 || month > 12 {
            return false
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yy"
        guard let enteredDate = dateFormatter.date(from: "\(expiryMonth)/\(expiryYear)") else { return false}
        guard let endOfMonth = Calendar.current.date(byAdding: .month, value: 1, to: enteredDate) else { return false}
        let now = Date()
        if (endOfMonth < now) {
            return false
        } else {
            return true
        }
    }
    
    static func luhnCheck(_ number: String) -> Bool {
        var sum = 0
        let digitStrings = number.reversed().map { String($0) }

        for tuple in digitStrings.enumerated() {
            if let digit = Int(tuple.element) {
                let odd = tuple.offset % 2 == 1

                switch (odd, digit) {
                case (true, 9):
                    sum += 9
                case (true, 0...8):
                    sum += (digit * 2) % 9
                default:
                    sum += digit
                }
            } else {
                return false
            }
        }
        return sum % 10 == 0
    }
    
    static func cardType(number: String) -> CardBrand {
        for card in CardBrand.allCreditCards {
            if (CCHelper.matchesRegex(regex: card.regex, text: number)) {
                return card
            }
        }
        return .undefined
    }
    
    static func matchesRegex(regex: String!, text: String!) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let nsString = text as NSString
            let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
            return (match != nil)
        } catch {
            return false
        }
    }

    static func formatCreditCardNumber(creditCardString : String) -> String {
        let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()

        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""

        if(arrOfCharacters.count > 0) {
            for i in 0...arrOfCharacters.count-1 {
                modifiedCreditCardString.append(arrOfCharacters[i])
                if((i+1) % 4 == 0 && i+1 != arrOfCharacters.count){
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        
        if CCHelper.cardType(number: creditCardString) == .amex || (creditCardString.count == 15 && creditCardString.contains("*")) {
            var stringArray = [String]()
            stringArray.append(creditCardString.substring(from: 0, to: 3))
            stringArray.append(creditCardString.substring(from: 4, to: 9))
            stringArray.append(creditCardString.substring(from: 10))
            
            return stringArray.joined(separator: " ")
        }
        
        return modifiedCreditCardString
    }
}
