//
//  CDAlertViewHelper.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 31/12/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit
import CDAlertView

class CDAlertViewBase: NSObject {
    var type: CDAlertViewType
    var title: String
    var message: String
    var button1: String?
    var button1Action: (() -> ())?
    var button2: String?
    var button2Action: (() -> ())?
    

    internal init(title: String, message: String, button1: String? = nil, button1Action: (() -> ())? = nil, button2: String? = nil, button2Action: (() -> ())? = nil) {
        self.type = .notification
        self.title = title
        self.message = message
        self.button1 = button1
        self.button1Action = button1Action
        self.button2 = button2
        self.button2Action = button2Action
    }
    
}

class ErrorAlertView: CDAlertViewBase {
    
    override var type: CDAlertViewType {
        get { return .error }
        set { }
    }
    
}
