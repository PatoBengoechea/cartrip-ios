//
//  UserViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 22/08/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit
import FirebaseStorage
import CDAlertView

class UserViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var creditCardsControlView: UIControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var licenseLabel: UILabel!
    @IBOutlet weak var licenseDateLabel: UILabel!
    @IBOutlet weak var addNewLicenseLabel: UILabel!
    @IBOutlet weak var addNewLicenseControl: UIControl!
    
    // MARK: - Properties
    var trips: [Trip] = [] {
        didSet { tableView.reloadData()}
    }
    
    var license: License? { didSet {
        licenseDateLabel.text = license?.expirationDateUI
        if license?.isExpired ?? true {
            licenseDateLabel.textColor = .systemRed
            addNewLicenseLabel.isHidden = false
            addNewLicenseControl.isHidden = false
        } else {
            licenseDateLabel.textColor = .systemGreen
            addNewLicenseLabel.isHidden = true
            addNewLicenseControl.isHidden = true
        }
    }}
    
    var name = ""
    var lastName = ""
    var imageName = ""
    private let picker = UIImagePickerController()
    
    // MARK: - @IBAction
    @IBAction func cardsButtonTapped() {
        performSegue(withIdentifier: R.segue.userViewController.goToShowCreditCards.identifier, sender: nil)
    }
    
    @IBAction func onAddLicenseTapped() {
        present(picker, animated: true)
    }
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        picker.allowsEditing = true
        picker.delegate = self
        customize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        TripManager.sharedInstance.getTrips(delegate: self, id: 11)
        UserManager.sharedInstance.getLicense(delegate: self)
        name = UserDefaults.standard.string(forKey: "name") ?? ""
        nameLabel.text = name ?? ""
        lastName = UserDefaults.standard.string(forKey: "lastName") ?? ""
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
        
        licenseLabel.set(font: .gothamRoundedMedium(12), color: .blueCar)
        licenseLabel.textAlignment = .left
        licenseLabel.text = "Fecha de caducidad de la licencia de conducir"
        licenseLabel.numberOfLines = 2
        
        licenseDateLabel.set(font: .gothamRoundedMedium(12), color: .systemGreen)
        licenseDateLabel.textAlignment = .left
        licenseDateLabel.text = ""
        
        addNewLicenseLabel.set(font: .gothamRoundedMedium(12), color: .blueCar)
        addNewLicenseLabel.textAlignment = .left
        
        addNewLicenseLabel.isHidden = true
        addNewLicenseLabel.text = "Agregar licencia de conducir"
        addNewLicenseControl.isHidden = true
    }

    private func showSuccess() {
        let alert = CDAlertView(title: R.string.localizable.theLicenseWasAdded(), message: R.string.localizable.waitUntilTheLiceseIsValidated(), type: .success)
        let doneAction = CDAlertViewAction(title: R.string.localizable.done()) { (action) -> Bool in
            return true
        }
        UserManager.sharedInstance.createLicense(delegate: self, path: imageName)
        alert.add(action: doneAction)
        alert.show()
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
        if license == nil {
            licenseLabel.isHidden = true
            licenseDateLabel.isHidden = true
            addNewLicenseLabel.isHidden = false
            addNewLicenseControl.isHidden = false
        }
        if license?.expirationDate == nil {
            licenseLabel.isHidden = false
            licenseLabel.text = "Su licencia de conducir esta siendo procesada"
            licenseDateLabel.isHidden = true
            addNewLicenseLabel.isHidden = true
            addNewLicenseControl.isHidden = true
        }
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

// MARK: - Image picker Delegate
extension UserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        Loader.showLoader()
        guard let im: UIImage = info[.editedImage] as? UIImage else { return }
        guard let d: Data = im.jpegData(compressionQuality: 0.5) else { return }
        
        let md = StorageMetadata()
        md.contentType = "image/png"
        
        let path = "\(name + lastName)\(UUID().uuidString)".hash
        imageName = "\(path).jpg"
        let ref = Storage.storage().reference().child(imageName)
        
        ref.putData(d, metadata: md) { (metadata, error) in
            if error == nil {
                ref.downloadURL(completion: { (url, error) in
                    print("Done, url is \(String(describing: url))")
                    Loader.dismiss()
                    self.showSuccess()
                })
            }else{
                Loader.dismiss()
                print("error \(String(describing: error))")
            }
        }
        
        dismiss(animated: true)
    }
}
