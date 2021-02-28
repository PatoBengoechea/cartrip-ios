//
//  TutorialViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 28/02/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        doneButton.backgroundColor = .blueCar
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.setTitle("Entendido", for: .normal)
        doneButton.titleLabel?.font = .gothamRoundedMedium(14)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        doneButton.setCornerRadius(cornerRadius: 10)
    }
    
    @IBAction func doneButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
