//
//  Extensions.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 16/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation
import UIKit


public extension UINavigationController {
    
    var root: UIViewController? {
        return viewControllers.first
    }
    class func initFrom(_ storyboard: String) -> UINavigationController? {
        return UIStoryboard(name: storyboard, bundle: nil).instantiateInitialViewController() as? UINavigationController
    }
}

extension UIView {
    func roundCorners(radius: CGFloat, corners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
    }
    
    func addShadowAndCornerRadius(cornerRadius: CGFloat = 25, color: UIColor = .black) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.layer.shadowRadius = 15.0
        self.layer.shadowOpacity = 0.8
        self.layer.cornerRadius = cornerRadius
    }
}


// MARK: - UIColor
extension UIColor {
    class var blueCar: UIColor {
        return UIColor(red: 18/255, green: 75/255, blue: 84/255, alpha: 1)
    }
}

