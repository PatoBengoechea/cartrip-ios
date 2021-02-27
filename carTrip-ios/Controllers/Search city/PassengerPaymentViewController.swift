//
//  PassengerPaymentViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 27/02/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import UIKit
import CDAlertView

class PassengerPaymentViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addToTripButtonView: UIView!
    @IBOutlet weak var addToTripButton: UIButton!
    
    let dataSource: [RentDataSource] = [.image, .creditCard, .prizeKM]
    
    var creditCard: CreditCard? { didSet {
        checkButton()
        tableView.reloadData()
    }}
    var trip: Trip?
    
    var kilometers: Int = 0
    
    @IBAction func onAddToTripButtonTapped() {
        ServiceManager.sharedInstance.addAsPassenger(idTrip: trip?.idTrip ?? 0) {
            let alert = CDAlertView(title: "Felicitaciones", message: "Te has sumado al viaje", type: .success)
            let doneAction = CDAlertViewAction(title: R.string.localizable.done()) { (action) -> Bool in
                self.navigationController?.popViewController(animated: true)
                return true
            }
            alert.add(action: doneAction)
            alert.show()
        } failureCallback: { (message) in
            let alert = CDAlertView(title: "Ha ocurrido un error", message: message, type: .error)
            alert.autoHideTime = 0.5
            alert.show()
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        customize()
        register()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let id = UserDefaults.standard.string(forKey: "idUser") ?? ""
        CreditCardManager.shared.getOneCreditCard(id: id, delegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ccVC = segue.destination as? CreditCardsViewController {
            ccVC.cardSelecterDelegate = self
            ccVC.selectable = true
        }
    }
    
    private func checkButton() {
        if let _ = creditCard {
            addToTripButton.isEnabled = true
        } else {
            addToTripButton.isEnabled = false
        }
    }
    
    private func customize() {
        addToTripButton.isEnabled = false
        addToTripButton.backgroundColor = .blueCar
        addToTripButton.setTitle("Sumarse", for: .normal)
        addToTripButton.setTitleColor(.white, for: .normal)
        addToTripButtonView.backgroundColor = .blueCar
    }

    private func register() {
        let kmnib = UINib(nibName: R.nib.prizeKMTableViewCell.name, bundle: nil)
        tableView.register(kmnib, forCellReuseIdentifier: R.reuseIdentifier.prizeKMTableViewCell.identifier)
        
        let imageNib = UINib(nibName: R.nib.imageTableViewCell.name, bundle: nil)
        tableView.register(imageNib, forCellReuseIdentifier: R.reuseIdentifier.imageTableViewCell.identifier)
        
        let ccNib = UINib(nibName: R.nib.profileCCTableViewCell.name, bundle: nil)
        tableView.register(ccNib, forCellReuseIdentifier: R.reuseIdentifier.profileCCTableViewCell.identifier)
    }
}

// MARK: - TABLE VIEW
extension PassengerPaymentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
        case .image:
            if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.imageTableViewCell, for: indexPath) {
                cell.setUp(image: trip?.carForRoad.car?.img_path ?? "")
                return cell
            }
        
        case .creditCard:
            if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.profileCCTableViewCell, for: indexPath) {
                cell.setUp(card: creditCard ?? CreditCard(), selecteable: true)
                return cell
            }
            
        case .prizeKM:
            if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.prizeKMTableViewCell, for: indexPath) {
                cell.setup(kilometers: kilometers, prizeKM: trip?.carForRoad.car?.type?.prizeKM ?? 0)
                return cell
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch dataSource[indexPath.row] {
        case .creditCard:
            performSegue(withIdentifier: R.segue.passengerPaymentViewController.goToAddCreditCard.identifier, sender: nil)
            let cell = tableView.cellForRow(at: indexPath)
            cell?.setHighlighted(false, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath.row] {
        case .image:
            return ImageTableViewCell.height
        case .days, .share, .price, .prizeKM, .informationShare, .from, .to:
            return UITableView.automaticDimension
        case .creditCard:
            return ProfileCCTableViewCell.height
        }
    }
}

// MARK: - Credit Card Delegate
extension PassengerPaymentViewController: CreditCardManagerDelegate {
    func onInitService() {
        Loader.showLoader()
    }
    
    func onFinishedService() {
        Loader.dismiss()
    }
    
    func onError(_ message: String) {
        print(message)
    }
    
    func onGetCreditCard(card: CreditCard) {
        creditCard = card
    }
    
}

// MARK : - Card Selecter Delegate
extension PassengerPaymentViewController: CreditCardSelectable {
    func onSelectCreditCard(card: CreditCard) {
        self.creditCard = card
    }
}
