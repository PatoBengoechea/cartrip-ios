//
//  RentViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 09/09/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit
import CDAlertView
import MapKit

protocol RentDelegate: NSObjectProtocol {
    var shareCar: Bool { get set }
    var howManyDays: Int { get set }
}

class RentViewController: UIViewController, RentDelegate {
    
    // MARK: - RentDelegate
    var shareCar: Bool = false { didSet {
        checkShareCar()
        }}
    var howManyDays: Int = 1 { didSet {
        reloadPrice()
        checkDays()
        }}
    
    
    // MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var nextButton: UIButton!

    // MARK: - Properties
    var currentCar: CarForRoadViewModel!
    private let presenter = RentPrenter<RentViewController>()
    private var toCity: String = ""
    private var destinyPlace: Place? { didSet {
        setDestiny(destinyPlace)
    }}
    var distance = 0.0
    
    var popVC: (() -> Void)?
    
    // MARK: - @IBAction
    @IBAction func nextButtonPressed() {
        onNextButtonPressed()
    }
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        presenter.getCarForRoad(id: currentCar.idCarForRoad)
        presenter.getOneCreditCard()
        customize()
        register()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.backgroundColor = .blueCar
        navigationController?.navigationBar.tintColor = .blueCar
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blueCar]
        navigationItem.title = R.string.localizable.rentYourCar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAssuranceModal()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let placeVC = segue.destination as? PlaceViewController, let places = sender as? [Place] {
            placeVC.places = places
            placeVC.choosePlace = { [weak self] place in
                self?.destinyPlace = place
            }
        }
        if let ccVC = segue.destination as? CreditCardsViewController {
            ccVC.selectable = true
            ccVC.cardSelecterDelegate = self
        }
    }
    
    // MARK: - Private Functions
    private func customize() {
        nextButton.backgroundColor = .blueCar
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitle(R.string.localizable.next(), for: .normal)
        
        nextView.backgroundColor = nextButton.backgroundColor
    }
    
    private func onNextButtonPressed() {
        let today = Date()
        var dateComponents = DateComponents()
        dateComponents.day = howManyDays
        if shareCar {
            presenter.createTrip(dateInit: today, dateFinish: nil, idDestiny: destinyPlace?.id)
        } else {
            presenter.createTrip(dateInit: today, dateFinish: Calendar.current.date(byAdding: dateComponents, to: today), idDestiny: nil)
        }
    }
    
    private func reloadPrice() {
        if let index = presenter.datasource.firstIndex(where: { $0 == .price }) {
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
            let days: Double = Double(howManyDays)
            let prizeRent: Double = Double(presenter.currentCar?.car?.type?.prizeRent ?? 1000)
            presenter.amount = days*prizeRent
        }
    }
    
    private func checkDays() {
        if howManyDays != 0 {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .blueCar
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .darkGray
        }
    }

    private func checkShareCar() {
        presenter.setDataSource(share: shareCar)
        tableView.reloadData()
    }
    
    private func setDestiny(_ place: Place?) {
        let coordinate0 = CLLocation(latitude: place?.latitude ?? 0.0, longitude: place?.longitude ?? 0.0)
        let coordinate1 = CLLocation(latitude: -32.9544955, longitude: -60.6441632)
        distance = coordinate0.distance(from: coordinate1)/1000 + 40
        let prizeKM = presenter.currentCar?.car?.type?.prizeKM ?? 0
        presenter.amount = distance*Double(prizeKM)
        presenter.destiny = place
        
        tableView.reloadData()
    }
    
    private func showAssuranceModal() {
        let alert = CDAlertView(title: "Seguro", message: "Al alquilar un vehiculo pagara un seguro de $5.000 que le será devuelto en 30 días en caso de no haber cometido infacciones", type: .notification)
        let action = CDAlertViewAction(title: "OK") { (action) -> Bool in
            return true
        }
        alert.add(action: action)
        alert.show()
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

// MARK: - Presenter Delegate
extension RentViewController: RentPresenterDelegate {
    func onGetCreditCard() {
        tableView.reloadData()
    }
    
    func onGetPlaces(places: [Place]) {
        if places.isEmpty {
            let alert = CDAlertView(title: R.string.localizable.thereAreNoReturnPointsInThatCity(), message: R.string.localizable.pleaseLookForAnotherCity(), type: .error)
            alert.autoHideTime = 4
            alert.show()
        } else {
            performSegue(withIdentifier: R.segue.rentViewController.goToPlaces.identifier, sender: places)
        }
    }
    
    func onRentCar() {
        let alert = CDAlertView(title: "Felicitaciones", message: "Alquilaste un: \(presenter.currentCar?.car?.fullName ?? "auto")", type: .success)
        let action = CDAlertViewAction(title: "OK") { (action) -> Bool in
            self.navigationController?.popViewController(animated: true)
            self.popVC?()
            return true
        }
        alert.add(action: action)
        alert.show()
    }
    
    func onGetCarForRoad() {
        reloadPrice()
    }
    
    func startLoading() {
        Loader.showLoader()
    }
    
    func finishedLoading() {
        Loader.dismiss()
    }
    
    func onError(message: String) {
        
    }
}

// MARK: - UITableView Delegates
extension RentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter.datasource[indexPath.row] {
        case .image:
            if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.imageTableViewCell, for: indexPath) {
                cell.setUp(image: currentCar.car?.img_path ?? "")
                return cell
            }
        case .days:
            if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.daysTableViewCell, for: indexPath) {
                cell.setUp(delegate: self, initialDays: howManyDays)
                return cell
            }
        case .share:
            if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.shareTableViewCell, for: indexPath) {
                cell.setUp(delegate: self)
                return cell
            }
        case .price:
            if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.priceTableViewCell, for: indexPath) {
                cell.setUp(type: presenter.currentCar?.car?.type, days: howManyDays, delegate: self)
                return cell
            }
        case .informationShare:
            if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.informationSharedTableViewCell, for: indexPath) {
                cell.setUpForInfo()
                return cell
            }
        case .from:
            if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.informationSharedTableViewCell, for: indexPath) {
                cell.setUpForLocation(self.currentCar)
                return cell
            }
        case .to:
            if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.locationTableViewCell, for: indexPath) {
                if let place = destinyPlace {
                    cell.setUp(place: place)
                } else {
                    cell.setUp(delegate: self)
                }
                return cell
            }
        case .creditCard:
            if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.profileCCTableViewCell, for: indexPath) {
                cell.setUp(card: presenter.currentCreditCard, selecteable: true)
                return cell
            }
        case .prizeKM:
            if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.prizeKMTableViewCell, for: indexPath) {
                cell.setup(kilometers: Int(distance.rounded()), prizeKM: presenter.currentCar?.car?.type?.prizeKM ?? 0)
                return cell
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch presenter.datasource[indexPath.row] {
        case .creditCard:
            performSegue(withIdentifier: R.segue.rentViewController.goToCreditCards.identifier, sender: nil)
            let cell = tableView.cellForRow(at: indexPath)
            cell?.setHighlighted(false, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch presenter.datasource[indexPath.row] {
        case .image:
            return ImageTableViewCell.height
        case .days, .share, .price, .prizeKM, .informationShare, .from, .to:
            return UITableView.automaticDimension
        case .creditCard:
            return ProfileCCTableViewCell.height
        default:
            return 0
        }
    }
    
    
}

// MARK: - City Delegate
extension RentViewController: CityEnteredDelegate {
    func onChangeCity(city: String) {
        toCity = city
    }
    
    func onContinue() {
        presenter.getPlaces(name: toCity)
    }
    
    
}

// MARK : - Card selected delegate
extension RentViewController: CreditCardSelectable {
    func onSelectCreditCard(card: CreditCard) {
        presenter.currentCreditCard = card
        tableView.reloadData()
    }
}
