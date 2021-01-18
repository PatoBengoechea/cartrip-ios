//
//  ListCarsViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 31/12/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

class ListCarsViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var carDataSource = [CarForRoadViewModel]()
    private var carsToLoad: [CarForRoadViewModel] = [CarForRoadViewModel]() { didSet {
        tableView.reloadSections(IndexSet(0...0), with: .top)
    }}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            
        carsToLoad = carDataSource
    }


}

// MARK: - Table View
extension ListCarsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsToLoad.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.listCarTableViewCell, for: indexPath) {
            cell.setUp(car: carsToLoad[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
