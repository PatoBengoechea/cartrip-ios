//
//  Extensions.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 16/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

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
    
    func hidde() {
        self.alpha = 0
        self.isHidden = true
    }
    
    func appear() {
        self.alpha = 1
        self.isHidden = false
    }
    
    func setCornerRadius(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func addShadow(color: UIColor, radious: CGFloat = 10) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = radious
        self.layer.shadowOpacity = 0.5
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

// MARK: - UILabel
extension UILabel {
    func set(font: UIFont, color: UIColor) {
        self.font = font
        self.textColor = color
    }
    
    func set(numberOfLines lines: Int, adjustFont: Bool) {
        self.numberOfLines = lines
        self.adjustsFontSizeToFitWidth = adjustFont
    }
}

// MARK: - String
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func substring(from: Int) -> String {
        return self.substring(from: from, to: nil)
    }
    
    func substring(to: Int) -> String {
        return self.substring(from: nil, to: to)
    }
    
    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else {
            return ""
        }
        
        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }
        
        return self.substring(from: from, to: end)
    }
    
    func substring(length: Int, to: Int?) -> String {
        guard let end = to, end > 0, length > 0 else {
            return ""
        }
        
        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }
        
        return self.substring(from: start, to: to)
    }
    
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.count else {
                return ""
            }
        }
        
        if let end = to {
            guard end > 0 else {
                return ""
            }
        }
        
        if let start = from, let end = to {
            if start == end {
                return self[start ..< end + 1]
            }
            guard end - start > 0 else {
                return ""
            }
        }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }
        
        return String(self[startIndex ..< endIndex])
    }
    
    subscript(i: Int) -> String {
        guard i >= 0 && i < count else { return "" }
        return String(self[index(startIndex, offsetBy: i)])
    }
    subscript(range: Range<Int>) -> String {
        let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) ?? endIndex
        return substring(with: lowerIndex..<(index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) ?? endIndex))
    }
    subscript(range: ClosedRange<Int>) -> String {
        let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) ?? endIndex
        return substring(with: lowerIndex..<(index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) ?? endIndex))
    }
}

// MARK: UI TextField
class CarTripTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    func carTripRadius() {
        self.setCornerRadius(cornerRadius: 20)
    }
}

extension UITextField {
    
    func underlined(color: UIColor) {
        let underline = UIView(frame: CGRect(x: 0, y: frame.height + 1, width: frame.width, height: 1))
        underline.backgroundColor = color
        underline.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleTopMargin]
        addSubview(underline)
        
        layer.masksToBounds = false
    }
}

// MARK: - Date
extension Date {
    func dateToString() -> String {
       let formatter = DateFormatter()
       formatter.dateStyle = .short
       return formatter.string(from: self)
   }
}

// MARK: - Image View
extension UIImageView {
    func setImage(image: String) {
        let url = URL(string: image)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}

// MARK: - Location Manager
extension CLLocationManager {
    
    func getCurrentCity(callback: @escaping (String) -> Void) {
        let coordinate = CLLocationCoordinate2D(latitude: -32.9544955, longitude: -60.6441632)
        let geoCoder = CLGeocoder()
        let clLocation = CLLocation(latitude: -32.9544955, longitude: -60.6441632)
        geoCoder.reverseGeocodeLocation(clLocation) { (placermarks, error) in
            guard let placeMark = placermarks?.first else { return }
            callback(placeMark.locality ?? "")
        }
        
    }
    
}

extension R {
    static let localizable = string.localizable.self
}
