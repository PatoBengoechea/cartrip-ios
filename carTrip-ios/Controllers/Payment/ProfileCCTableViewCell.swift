//
//  ProfileCCTableViewCell.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 31/01/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import UIKit

class ProfileCCTableViewCell: UITableViewCell {
    
    var creditCard: CreditCard?
    
    static var height: CGFloat = 60
//    var remove: ((_ creditCard: CreditCardViewModel) -> Void)?
    
    @IBOutlet weak var numberLabel : UILabel!
    @IBOutlet weak var ccImage: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        numberLabel.font = UIFont.LatoRegular(14)
//        numberLabel.textColor = CinemexColors.darkGray()
//        deleteButton.setImage(R.image.iconTrash()?.with(color: CinemexColors.darkGray()), for: .normal)
//        ccImage.tintColor = CinemexColors.darkGray(CinemexColors.lightGray())
        numberLabel.set(font: .gothamRoundedMedium(16), color: .blueCar)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//    func populate(_ creditCard: CreditCardViewModel, remove: @escaping ((_ creditCard: CreditCardViewModel) -> Void)) {
//        self.creditCard = creditCard
//        self.remove = remove
//
//        ccImage.image = creditCard.logo
//        numberLabel.text = creditCard.redactedNumber
//    }
    
    func setUp(card: CreditCard) {
        numberLabel.text = CCHelper.formatCreditCardNumber(creditCardString: card.number)
        ccImage.image = CCHelper.cardType(number: card.number).image
    }
    
    @IBAction func onRemoveButton(_ sender: AnyObject) {
//        if let handler = self.remove, let cc = self.creditCard {
//            let dialog = CinemexDialog(title: R.localizable.attention(),
//                                       message: R.localizable.deleteCCQuestion())
//            dialog.setOkButton(title: R.localizable.yes()) {
//                handler(cc)
//            }
//            dialog.setCancelButton(title: R.localizable.cancel())
//            dialog.present()
//        }
    }

}
