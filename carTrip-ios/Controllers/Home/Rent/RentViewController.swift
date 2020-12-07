//
//  RentViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 09/09/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit
import CDAlertView

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
    
    // MARK: - @IBAction
    @IBAction func nextButtonPressed() {
        onNextButtonPressed()
    }
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        presenter.getCarForRoad(id: currentCar.idCarForRoad)
        customize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = R.string.localizable.rentYourCar()
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
            let alert = CDAlertView(title: "Awesome Title", message: "Well explained message!", type: .error)
            alert.show()
        } else {
            presenter.createTrip(dateInit: today, dateFinish: Calendar.current.date(byAdding: dateComponents, to: today))
        }
    }
    
    private func reloadPrice() {
        if let index = presenter.datasource.firstIndex(where: { $0 == .price }) {
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
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
//        if shareCar {
//            if let priceIndex = presenter.datasource.firstIndex(where: { $0 == .price}),
//                let dayIndex = presenter.datasource.firstIndex(where: { $0 == .days}) {
//            let indexPaths = [IndexPath(row: dayIndex, section: 0), IndexPath(row: priceIndex, section: 0)]
//                tableView.deleteRows(at: indexPaths, with: .fade)
//            }
//        } else {
//            let count = presenter.datasource.count
//            let indexPaths = [IndexPath(row: count, section: 0), IndexPath(row: (count + 1), section: 0)]
//            tableView.insertRows(at: indexPaths, with: .fade)
//        }
    }
}

// MARK: - Presenter Delegate
extension RentViewController: RentPresenterDelegate {
    func onRentCar() {
        let alert = CDAlertView(title: R.string.localizable.carRent(), message: "", type: .success)
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
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch presenter.datasource[indexPath.row] {
        case .image:
            return ImageTableViewCell.height
        case .days, .share, .price:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    
}