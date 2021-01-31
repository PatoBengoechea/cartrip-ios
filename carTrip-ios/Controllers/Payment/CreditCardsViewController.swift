//
//  CreditCardsViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 30/01/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import UIKit

class CreditCardsViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var addCardButton: UIButton!
    
    // MARK: - Properties
    var cards: [CreditCard] = [] {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - @IBAction
    @IBAction func onAddButtonTapped() {
        performSegue(withIdentifier: R.segue.creditCardsViewController.goToAddCard.identifier, sender: nil)
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
        let id = UserDefaults.standard.string(forKey: "idUser")!
        CreditCardManager.shared.getCreditCard(id: id, delegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddCardViewController {
            addVC.setSaveCallback {
                let id = UserDefaults.standard.string(forKey: "idUser")!
                CreditCardManager.shared.getCreditCard(id: id, delegate: self)
            }
        }
    }
    
    // MARK: - Private Functions
    private func customize() {
        buttonView.backgroundColor = .blueCar
        addCardButton.backgroundColor = .blueCar
        addCardButton.setTitle(R.localizable.add(), for: .normal)
        addCardButton.setTitleColor(.white, for: .normal)
    }

}

// MARK: - CREDIT CARD MANAGER DELEGATE
extension CreditCardsViewController: CreditCardManagerDelegate {
    func cardAdded() {
        
    }
    
    func onGetCreditCards(cards: [CreditCard]) {
        self.cards = cards
    }
    
    func onInitService() {
        Loader.showLoader()
    }
    
    func onFinishedService() {
        Loader.dismiss()
    }
    
    func onError(_ message: String) {
        
    }
}

// MARK: - TABLE VIEW DELEGATE
extension CreditCardsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.profileCCTableViewCell, for: indexPath) {
            cell.setUp(card: cards[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
