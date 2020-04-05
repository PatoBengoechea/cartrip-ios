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
    
    func addShadow( color: UIColor = .black, radius: CGFloat = 10, shadowOffset: CGSize = .zero, shadowOpacity: CGFloat = 1) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = radius
    }
}


// MARK: - UIColor
extension UIColor {
    class var blueCar: UIColor {
        return UIColor(red: 18/255, green: 75/255, blue: 84/255, alpha: 1)
    }
    
    class var primaryGreen: UIColor {
        return UIColor(red: 142/255, green: 213/255, blue: 45/255, alpha: 1)
    }
}

// MARK: - UIFont
extension UIFont {
    
    class func gothamRoundedBold(_ size: Int) -> UIFont {
        return UIFont(name: "GothamRounded-Bold", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    class func gothamRoundedBoldItalic(_ size: Int) -> UIFont {
        return UIFont(name: R.font.gothamRoundedBoldItalic.fontName, size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    class func gothamRoundedBook(_ size: Int) -> UIFont {
        return UIFont(name: "GothamRounded-Book", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    class func gothamRoundedBookItalic(_ size: Int) -> UIFont {
        return UIFont(name: R.font.gothamRoundedBookItalic.fontName, size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    class func gothamRoundedLight(_ size: Int) -> UIFont {
        return UIFont(name: "GothamRounded-Light", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    class func gothamRoundedLightItalic(_ size: Int) -> UIFont {
        return UIFont(name: R.font.gothamRoundedLightItalic.fontName, size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    class func gothamRoundedMedium(_ size: Int) -> UIFont {
        return UIFont(name: "GothamRounded-Medium", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    class func gothamRoundedMediiumItalic(_ size: Int) -> UIFont {
        return UIFont(name: "GothamRounded-MediumItalic", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    class func gothamRoundedBold21016(_ size: Int) -> UIFont {
        return UIFont(name: "GothamRoundedBold_21016", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    class func gothamRoundedBold21018(_ size: Int) -> UIFont {
        return UIFont(name: "GothamRoundedBold_21018", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    class func gothamRoundedBold21020(_ size: Int) -> UIFont {
        return UIFont(name: "GothamRoundedBold_21020", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    class func gothamRoundedBold21022(_ size: Int) -> UIFont {
        return UIFont(name: "GothamRoundedBold_21022", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
}

