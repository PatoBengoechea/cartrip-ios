//
//  UserViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 22/08/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var creditCardsControlView: UIControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var trips: [Trip] = [] {
        didSet { tableView.reloadData()}
    }
    
    var license: License?
    
    // MARK: - @IBAction
    @IBAction func cardsButtonTapped() {
        performSegue(withIdentifier: R.segue.userViewController.goToShowCreditCards.identifier, sender: nil)
    }
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        customize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        TripManager.sharedInstance.getTrips(delegate: self, id: 11)
        UserManager.sharedInstance.getLicense(delegate: self)
        let name = UserDefaults.standard.string(forKey: "name")
        nameLabel.text = name ?? ""
        let lastName = UserDefaults.standard.string(forKey: "lastName")
        lastNameLabel.text = lastName ?? ""
        
    }
    
    private func customize() {
        navigationController?.navigationBar.backgroundColor = .blueCar
        navigationController?.navigationBar.tintColor = .blueCar
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blueCar]
        navigationItem.title = R.string.localizable.profile()
        
        nameLabel.set(font: .gothamRoundedMedium(16), color: .blueCar)
        nameLabel.textAlignment = .right
        lastNameLabel.set(font: .gothamRoundedMedium(16), color: .blueCar)
        lastNameLabel.textAlignment = .left
    }

}

// MARK: - Trip Manager Delegate
extension UserViewController: TripManagerDelegate, UserManagerDelegate {
    func onInitService() {
        
    }
    
    func onFinishedService() {
        
    }
    
    func onError(_ message: String) {
        print(message)
    }
    
    func onGetTrips(trips: [Trip]) {
        self.trips = trips
    }
    
    func onGetLicense(license: License?) {
        self.license = license
    }
}

// MARK: - UITableview Delegate
extension UserViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.tripTableViewCell, for: indexPath) {
            cell.setUp(trip: trips[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
