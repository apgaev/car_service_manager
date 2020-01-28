//
//  CarViewController.swift
//  car_service_manager
//
//  Created by Anton Gaev on 17.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit
import CoreData

class CarViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var carNumberTextField: UITextField!
    @IBOutlet weak var saveImage: UIImageView!
    @IBOutlet weak var clientNameTextInput: UITextField!
    @IBOutlet weak var carTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    let imagePicker = UIImagePickerController()
//    var repairs: [String] = ["Бампер", "Крыло"]
    var isUpdate = Bool()
    var indexRow: UUID?
    var carDetails: Car?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
//        tableView.dataSource = self
        makeTappableImage()
    }
    
    func setUI() {
        if isUpdate {
            clientNameTextInput.text = carDetails?.owner
            carTextField.text = carDetails?.carName
            phoneTextField.text = carDetails?.phone
            if let theImage = carDetails?.carImage {
                saveImage.image = UIImage(data: theImage)
            }
        }
    }
    
    @IBAction func saveClick(_ sender: Any) {
        let dict = ["carName": carTextField.text, "owner": clientNameTextInput.text, "phone": phoneTextField.text]
        let png = self.saveImage.image?.pngData()
        if isUpdate {
            DatabaseHelper.shareInstance.editData(object: dict as! [String: String], image: png!,  i: indexRow!)
        } else {
            DatabaseHelper.shareInstance.save(object: dict as! [String:String], image: png!)
        }
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "toCarViewController" {
//                let popup = segue.destination as! ProcessDetailsViewController
//                popup.onSave = { (data) in
//                    self.repairs.append(data)
//                    self.tableView.reloadData()
//                }
//            }
//        }
}

//extension CarViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return repairs.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CarTableViewCell
//        cell.titleLabel.text = repairs[indexPath.row]
//        return cell
//    }
//}

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
