//
//  Constants.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 16/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation
import UIKit


class CornerShadowView: UIControl {
    var presetCornerRadius: CGFloat = 25.0
    /*
     once the bounds of the drop shadow view (container view) is initialized,
     the bounds variable value will be set/updated and the
     setupShadow method will run
     */
    override var bounds: CGRect {
        didSet {
            setupShadowPath()
        }
    }
    
    private func setupShadowPath() {
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: presetCornerRadius).cgPath
        
        // further optimization by rasterizing the container view and its shadow into bitmap instead of dynamically rendering it every time
        // take note that the rasterized bitmap will be saved into memory and it might take quite some memory if you have many cells
        
        // self.layer.shouldRasterize = true
        // self.layer.rasterizationScale = UIScreen.main.scale
    }
}

class DefaultManager {
    
    enum DefaultManagerKey: String {
        case idUser
    }
    
    static func set<T>(value: T, forKey key: DefaultManagerKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

}


// MARK: - Gradient View
class GradientView: UIView, CAAnimationDelegate {
    
    var newsColors: [Any] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupView(fromColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0), toColor: UIColor, startPoint: CGPoint = CGPoint(x: 0, y: 0.5), endPoint: CGPoint = CGPoint(x: 1, y: 0.5)) {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]

        guard let theLayer = self.layer as? CAGradientLayer else {
            return
        }

        theLayer.colors = [fromColor.cgColor, toColor.cgColor]
        theLayer.startPoint = CGPoint(x: 0, y: 0.5)
        theLayer.endPoint = CGPoint(x: 1, y: 0.5)
        theLayer.frame = self.bounds
    }
    
    func setNewColors(fromColor: UIColor, toColor: UIColor) {
        let toColors: [AnyObject] = [ fromColor.cgColor, toColor.cgColor]

        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")

        guard let layer = self.layer as? CAGradientLayer else { return }
        
        animation.fromValue = layer.colors
        animation.toValue = toColors
        newsColors = toColors
        animation.duration = 0.5
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.delegate = self
        
        
        layer.add(animation, forKey:"animateGradient")
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}


protocol CheckBoxDelegate {
    func onCheckBockTapped(check: Bool)
}
class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(systemName: "checkmark.square")! as UIImage
    let uncheckedImage = UIImage(systemName: "square")! as UIImage
    var delegate: CheckBoxDelegate?
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
        
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.tintColor = .white
        self.isChecked = false
    }
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
            delegate?.onCheckBockTapped(check: isChecked)
        }
    }
}
