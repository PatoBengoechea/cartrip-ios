//
//  SearchCityViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 23/01/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import UIKit

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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        searchBar.placeholder = R.string.localizable.filterByDestinyCity()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        let city = UserDefaults.standard.string(forKey: "actual_city")
        ServiceManager.sharedInstance.getTrips(from: city!) { (trips) in
            
            self.tripsDataSource = trips
            self.trips = trips
            
        } failureCallback: { (message) in
            
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
