//
//  ImageTableViewCell.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 21/09/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var carImageView: UIImageView!
    
    // MARK: - Properties
    static var height: CGFloat = 200    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - Functions
    func setUp(image: String) {
        carImageView.setImage(image: image)
    }

}
