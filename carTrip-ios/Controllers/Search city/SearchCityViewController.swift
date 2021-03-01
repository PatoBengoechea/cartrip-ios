//
//  SearchCityViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 23/01/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import UIKit
import MapKit

class SearchCityViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private var tripsDataSource: [Trip] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var trips: [Trip] = []
    
    private var whenBackAction: (()->())?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: R.nib.tripFromToTableViewCell.name, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: R.reuseIdentifier.tripFromToTableViewCell.identifier)
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.placeholder = R.string.localizable.filterByDestinyCity()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Viajes disponibles"
        navigationController?.navigationBar.tintColor = .blueCar
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blueCar]
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        let city = UserDefaults.standard.string(forKey: "actual_city")
        ServiceManager.sharedInstance.getTrips(from: city!) { (trips) in
            
            self.tripsDataSource = trips
            self.trips = trips
            
        } failureCallback: { (message) in
            
        }
        
        whenBackAction?()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ppVC = segue.destination as? PassengerPaymentViewController, let trip = sender as? Trip {
            ppVC.trip = trip
            let coordinate0 = CLLocation(latitude: trip.destinyPlace.latitude , longitude: trip.destinyPlace.longitude )
            let coordinate1 = CLLocation(latitude: -32.9544955, longitude: -60.6441632)
            ppVC.kilometers = Int(coordinate0.distance(from: coordinate1)/1000 + 40)
            
            whenBackAction = {
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
}


// MARK: - TextfieldDelegate
extension SearchCityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchBar.text!.lowercased()
        if text.isEmpty {
            tripsDataSource = trips
        } else {
            tripsDataSource = trips.filter {
                $0.destinyPlace.cityName.lowercased().contains(text)
            }
        }
    }
}

// MARK: - UI Table View delegate
extension SearchCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripsDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.tripFromToTableViewCell, for: indexPath) {
            cell.setUp(trip: tripsDataSource[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trip = tripsDataSource[indexPath.row]
        performSegue(withIdentifier: R.segue.searchCityViewController.goToPayment, sender: trip)
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setHighlighted(false, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
