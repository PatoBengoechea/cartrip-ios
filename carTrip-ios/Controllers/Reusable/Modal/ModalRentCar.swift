//
//  Modal.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 04/04/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ModalRentCar: UIViewController {
    
    @IBOutlet var modalView: UIView!
    @IBOutlet var titleView: UIView!
    @IBOutlet var bodyView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var carLabel: UILabel!
    @IBOutlet var carImage: UIImageView!
    @IBOutlet var rentButton: UIButton!
    @IBOutlet var leadingModal: NSLayoutConstraint!
    @IBOutlet var trailingModal: NSLayoutConstraint!
    @IBOutlet var heightModal: NSLayoutConstraint!
    
    // MARK: - Properties
    private var completion: (() -> Void)?
    private var car: CarForRoadViewModel?
    
    // MARK: - @IBAction
    @IBAction private func rentButtonTapped() {
        dismiss(animated: true) { [unowned self ] in
            self.completion?()
        }
    }
    
    @IBAction private func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - init
    init(car: CarForRoadViewModel, completion: @escaping () -> Void) {
        super.init(nibName: nil, bundle: nil)
        self.car = car
        self.completion = completion
        
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        modalView.roundCorners(radius: 20, corners: .allCorners)
        carImage.roundCorners(radius: 10, corners: .allCorners)
        rentButton.addShadow(color: .gray, radius: 10)
           
        view.layoutIfNeeded()
       }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.leadingModal.constant = 30
        self.trailingModal.constant = 30
        UIView.animate(withDuration: 0.5, delay: 0,
                       usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                        self.modalView.layoutIfNeeded()
        }) { (_) in
            self.heightModal.constant = 400
            UIView.animate(withDuration: 0.5, delay: 0,
                           usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                            self.modalView.layoutIfNeeded()
                            
            }) { (_) in
                UIView.animate(withDuration: 0.2, delay: 0,
                               usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                                self.carImage.alpha = 1
                                self.titleLabel.alpha = 1
                                self.carLabel.alpha = 1
                                self.rentButton.alpha = 1
                                
                }) { (_) in
                    
                }
            }
        }
    }
    
    private func setUp() {
        carLabel.text = car?.car?.fullName
        carLabel.textColor = .blueCar
        carLabel.font = .gothamRoundedMedium(20)
        
        titleLabel.textColor = .white
        titleLabel.text = R.string.localizable.letSGoToTakeADrive()
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = .gothamRoundedMedium(24)
        
        titleView.backgroundColor = .blueCar
        
        rentButton.backgroundColor = .primaryGreen
        rentButton.setTitleColor(.white, for: .normal)
        rentButton.setTitle(R.string.localizable.rent().localizedCapitalized, for: .normal)
        rentButton.titleLabel?.font = .gothamRoundedMedium(24)
        
        leadingModal.constant = (view.frame.width / 2)
        trailingModal.constant = (view.frame.width / 2)
        heightModal.constant = 20
        
        self.carImage.alpha = 0
        self.titleLabel.alpha = 0
        self.carLabel.alpha = 0
        self.rentButton.alpha = 0
        
        configureImage()
    }
    
    private func configureImage() {
        let url = URL(string: car?.car?.img_path ?? "")
        carImage.kf.indicatorType = .activity
        carImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: R.image.freeLogo.name),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
    // MARK: - Functions
    func present() {
        if let controller = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController {
            controller.present(self, animated: true, completion: nil)
        } else {
            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
        }
    }
}

