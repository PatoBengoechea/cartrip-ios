//
//  CreditCardView.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 30/01/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import UIKit

class CreditCardView: UIView {

    // MARK: - @IBOutlet
    @IBOutlet var contentView: UIView!
    @IBOutlet var gradientView: GradientView!
    @IBOutlet var ccBrand: UIImageView!
    @IBOutlet var ccNumber: UILabel!
    @IBOutlet var ccName: UILabel!
    @IBOutlet var ccExpirationLabel: UILabel!
    @IBOutlet var deleteCCButton: UIButton!
    
    // MARK: - Properties
    var remove: (() -> Void)?
    var messageToDelete: String?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CreditCardView", owner: self, options: nil)
        print(self.description)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.roundCorners(radius: 10, corners: .allCorners)
    }
    
    // MARK: - @IBActions
    @IBAction func onRemoveButton(_ sender: AnyObject) {
//        let dialog = CinemexDialog(title: R.localizable.attention(),
//                                   message: messageToDelete ?? R.localizable.deleteCCQuestion())
//        dialog.setOkButton(title: R.localizable.yes()) { [unowned self] in
//            UIView.transition(with: self,
//                              duration: 0.5,
//                              options: .curveEaseInOut,
//                              animations: {
//                                self.ccBrand.image = UIImage()
//                                self.ccNumber.text = ""
//                                self.ccExpirationLabel.text = ""
//            }, completion: nil)
//            self.remove?()
//        }
//        dialog.setCancelButton(title: R.localizable.cancel())
//        dialog.present()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        customize()
    }
    
    func setRemoveCallback(completion: @escaping ()->()) {
        remove = completion
    }
    
    // MARK: - Functions
    func setCardImage(image: UIImage?) {
        ccBrand.image = image
    }
    
    func setCardNumber(number: String) {
        if number.isEmpty {
            self.ccNumber.text = "**** **** **** ****"
        } else {
            ccNumber.text = CCHelper.formatCreditCardNumber(creditCardString: number)
        }
    }
    
    func setDate(date: String) {
        if date.isEmpty {
            self.ccExpirationLabel.text = "--/--"
        } else {
            ccExpirationLabel.text = date
        }
    }
    
    func setFullName(name: String) {
        self.ccName.text = name
    }
    
//    func setUp(creditCard: CreditCardViewModel, deleteHandler: @escaping (()->())) {
//        ccBrand.image = creditCard.logo
//        ccNumber.text = creditCard.redactedNumber
//        ccName.text = creditCard.cardName
//        ccExpirationLabel.text = "\(creditCard.expiryMonth)/\(creditCard.expiryYearShort)"
//        gradientView.setupView(fromColor: creditCard.getGradientFromColor(), toColor: creditCard.getGradientToColor())
//        remove = deleteHandler
//    }
    
    func disableRemoveButton() {
        deleteCCButton.isHidden = true
    }
    
    func setNewGradientColor(fromColor: UIColor, toColor: UIColor) {
        gradientView.setNewColors(fromColor: fromColor, toColor: toColor)
    }
    
    // MARK: - Private Functions
    private func customize() {
        self.ccNumber.textColor = .white
        self.ccNumber.adjustsFontSizeToFitWidth = true
        self.ccNumber.textAlignment = .center
        self.ccNumber.font = .gothamRoundedMedium(18)
        
        self.ccName.textColor = .white
        self.ccName.font = .gothamRoundedMedium(18)
        self.ccName.text = ""
        self.ccName.numberOfLines = 2
        self.ccName.adjustsFontSizeToFitWidth = false
        
        self.ccExpirationLabel.textColor = .white
        self.ccExpirationLabel.font = .gothamRoundedMedium(18)
        self.ccExpirationLabel.textAlignment = .right
        
        self.ccNumber.text = "**** **** **** ****"
        self.ccExpirationLabel.text = "--/--"
        self.ccBrand.image = R.image.ccPlaceholder()
        self.ccBrand.tintColor = .white
    }

}
