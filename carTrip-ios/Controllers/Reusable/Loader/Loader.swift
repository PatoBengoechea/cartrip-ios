//
//  Loader.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 05/04/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class Loader: UIView {
    
    static var currentView: Loader?
    
    class func showLoader() {
        if currentView == nil {
            let view = Loader(frame: CGRect(x: 0, y: 0, width: UIApplication.shared.keyWindow?.rootViewController?.view.frame.width ?? 0/2, height: UIApplication.shared.keyWindow?.rootViewController?.view.frame.height ?? 0/2))
            currentView = view
            let animationView = AnimationView(name: R.file.sedanCarAnimationJson.name)
            animationView.frame = CGRect(x: currentView!.frame.width/2, y: currentView!.frame.height/2, width: 300, height: 150)
            animationView.center = currentView?.center ?? CGPoint(x: 0, y: 0)
            UIApplication.shared.keyWindow?.addSubview(currentView!)
            animationView.contentMode = .scaleToFill
            
            currentView?.addSubview(animationView)
            currentView?.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            animationView.loopMode = .loop
            animationView.play()
        }
    }
    
    class func dismiss() {
        UIView.animate(withDuration: 0.2, animations: {
            self.currentView?.alpha = 0
        }) { (completion) in
            self.currentView?.removeFromSuperview()
            currentView = nil
        }
    }

}

