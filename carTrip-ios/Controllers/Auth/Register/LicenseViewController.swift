//
//  LicenseViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 07/12/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit
import FirebaseStorage
import CDAlertView

class LicenseViewController: RegisterBaseViewController {
    
    @IBOutlet weak var licenseLabel: UILabel!
    @IBOutlet weak var addLicenseButton: UIButton!
    @IBOutlet weak var laterLicenseButton: UIButton!
    
    weak var rootDelegate: RootViewControllerDelegate?
    private var imageName = ""
    private let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        picker.allowsEditing = true
        picker.delegate = self
        
        customize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addLicenseButton.setCornerRadius(cornerRadius: 10)
        laterLicenseButton.setCornerRadius(cornerRadius: 10)
    }
    
    @IBAction func addLicense() {
        present(picker, animated: true)
    }
    
    @IBAction func addLaterLicense() {
        presenter?.registerUser()
    }

    
    private func customize() {
        licenseLabel.set(font: .gothamRoundedMedium(16), color: .blueCar)
        licenseLabel.textAlignment = .center
        licenseLabel.text = R.string.localizable.textToLicense()
        
        addLicenseButton.backgroundColor = .blueCar
        addLicenseButton.setTitle(R.string.localizable.add(), for: .normal)
        addLicenseButton.titleLabel?.font = .gothamRoundedMedium(14)
        addLicenseButton.tintColor = .white
        
        laterLicenseButton.backgroundColor = .lightGray
        laterLicenseButton.setTitle(R.string.localizable.addLater(), for: .normal)
        laterLicenseButton.titleLabel?.font = .gothamRoundedMedium(14)
        laterLicenseButton.tintColor = .blueCar
    }
    
    private func showSuccess() {
        let alert = CDAlertView(title: R.string.localizable.theLicenseWasAdded(), message: R.string.localizable.waitUntilTheLiceseIsValidated(), type: .success)
        let doneAction = CDAlertViewAction(title: R.string.localizable.finishRegistration()) { (action) -> Bool in
            self.presenter?.registerUser()
            return true
        }
        alert.add(action: doneAction)
        alert.show()
    }
}

// MARK: - Register Delegate
extension LicenseViewController: RegisterPresenterDelegate {
    func onRegister() {
        let alert = CDAlertView(title: R.string.localizable.finishRegistration(), message: "", type: .success)
        alert.autoHideTime = 0.5
        alert.show()
        rootDelegate?.showHome()
    }
}

// MARK: - Image picker Delegate
extension LicenseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        Loader.showLoader()
        guard let im: UIImage = info[.editedImage] as? UIImage else { return }
        guard let d: Data = im.jpegData(compressionQuality: 0.5) else { return }
        
        let md = StorageMetadata()
        md.contentType = "image/png"
        
        let path = "\(presenter?.getEmail() ?? "")\(UUID().uuidString)".hash
        imageName = "\(path).jpg"
        let ref = Storage.storage().reference().child(imageName)
        
        ref.putData(d, metadata: md) { (metadata, error) in
            if error == nil {
                ref.downloadURL(completion: { (url, error) in
                    print("Done, url is \(String(describing: url))")
                    self.presenter?.setImageLicensePath(self.imageName)
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
