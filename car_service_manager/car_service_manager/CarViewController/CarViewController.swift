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
    
//    let imagePicker = UIImagePickerController()
//    var repairs: [String] = ["Бампер", "Крыло"]
    var carToEdit = [Car: Int]()
    var isUpdate = Bool()
    var i = Int()
//    var onSave: ((_ data: Car) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        //tableView.dataSource = self
//        coreDataInitialSetup()
//        makeTappableImage()
    }
    
    func setUI() {
        clientNameTextInput.text = carToEdit.keys.first?.owner
        carTextField.text = carToEdit.keys.first?.carName
        
        if let index = carToEdit.values.first {
            i = index
        }
    }
    
    @IBAction func saveClick(_ sender: Any) {
        let dict = ["carName": carTextField.text, "owner": clientNameTextInput.text, "phone": phoneTextField.text]
        if isUpdate {
            DatabaseHelper.shareInstance.editData(object: dict as! [String: String], i: i)
        } else {
            DatabaseHelper.shareInstance.save(object: dict as! [String:String])
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
    
//    @IBAction func returnWithSomeDataToContactsViewController(_ sender: Any) {
//        if let car = self.carToEdit {
//            car.carName = carTextField.text!
//            car.owner = clientNameTextInput.text!
//            car.carImage = self.saveImage.image?.pngData()
//            car.phone = phoneTextField.text!
//            //PersistanceService.saveContext()
//            DispatchQueue.main.async {
//                self.onSave?(car)
//            }
//        } else {
//            let car = Car(context: PersistanceService.context)
//            car.carName = carTextField.text!
//            car.owner = clientNameTextInput.text!
//            car.carImage = self.saveImage.image?.pngData()
//            car.phone = phoneTextField.text!
//            car.id = UUID()
//            //PersistanceService.saveContext()
//            DispatchQueue.main.async {
//                self.onSave?(car)
//            }
//        }
//        dismiss(animated: true)
//    }
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

// MARK: - Core Data layout functions
//extension CarViewController {
//    func coreDataInitialSetup () {
//        //fill the form with editied cell's properties
//        if let index = self.carToEdit {
//            //let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
//                if let imageData = index.carImage {
//                    backgroundImageView.image = UIImage(data: imageData)
//                }
//                if let carName = index.owner {
//                    carTextField.text = carName
//                }
//                if let clientName = index.carName {
//                    clientNameTextInput.text = clientName
//                }
//        }
//    }
//}

// MARK: - Tappable Image Functions
//extension CarViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//
//    func makeTappableImage () {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectImage(gesture:)))
//        tapGesture.numberOfTouchesRequired = 1
//        self.saveImage.isUserInteractionEnabled = true
//        self.saveImage.addGestureRecognizer(tapGesture)
//    }
//
//    @objc func selectImage(gesture: UITapGestureRecognizer) {
//        self.openImagePicker()
//    }
//
//    func openImagePicker() {
//        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
//            imagePicker.delegate = self
//            imagePicker.sourceType = .savedPhotosAlbum
//            imagePicker.allowsEditing = false
//            present(imagePicker, animated: true, completion: nil)
//        }
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        dismiss(animated: true, completion: nil)
//        if let img = info[.originalImage] as? UIImage {
//            self.saveImage.image = img
//        }
//    }
//}
