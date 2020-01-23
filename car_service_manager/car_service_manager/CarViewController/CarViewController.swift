//
//  CarViewController.swift
//  car_service_manager
//
//  Created by Anton Gaev on 17.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var carNumberTextField: UITextField!
    @IBOutlet weak var saveImage: UIImageView!
    @IBOutlet weak var clientNameTextInput: UITextField!
    @IBOutlet weak var carTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    let imagePicker = UIImagePickerController()
    var repairs: [String] = ["Бампер", "Крыло"]
    
    var onSave: ((_ data: Car) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        makeTappableImage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toCarViewController" {
                let popup = segue.destination as! ProcessDetailsViewController
                popup.onSave = { (data) in
                    self.repairs.append(data)
                    self.tableView.reloadData()
                }
            }
        }
    
    @IBAction func returnWithSomeDataToContactsViewController(_ sender: Any) {
                let name = clientNameTextInput.text!
                let carName = carTextField.text!
                let car = Car(context: PersistanceService.context)
                let png = self.saveImage.image?.pngData()
                car.carName = carName
                car.owner = name
                car.carImage = png
                car.phone = phoneTextField.text!
                
                //self.contacts.append(car)
                //self.contactsTableView.reloadData()
                PersistanceService.saveContext()
                onSave?(car)
                dismiss(animated: true)
    }
    
}

extension CarViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repairs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CarTableViewCell
        cell.titleLabel.text = repairs[indexPath.row]
        return cell
    }
}

// MARK: - Tappable Image Functions
extension CarViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    func makeTappableImage () {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectImage(gesture:)))
        tapGesture.numberOfTouchesRequired = 1
        self.saveImage.isUserInteractionEnabled = true
        self.saveImage.addGestureRecognizer(tapGesture)
    }

    @objc func selectImage(gesture: UITapGestureRecognizer) {
        self.openImagePicker()
    }

    func openImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let img = info[.originalImage] as? UIImage {
            self.saveImage.image = img
        }
    }
}
