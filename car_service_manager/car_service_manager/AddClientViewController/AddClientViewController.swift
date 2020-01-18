//
//  AddClientViewController.swift
//  car_service_manager
//
//  Created by Anton Gaev on 17.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit
import Photos

class AddClientViewController: UIViewController {

    @IBOutlet weak var addClientPopupView: UIView!
    @IBOutlet weak var clientTextField: UITextField!
    @IBOutlet weak var carImageView: UIImageView!
    
    var doneSaving : (() -> ())?
    var clientIndexToEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addClientPopupView.addShadowAndRoundedCorners()
        
        if let index = clientIndexToEdit {
            let client = Data.clientModels[index]
            clientTextField.text = client.clientName
            carImageView.image = client.carImage
        }
    }
    
    fileprivate func presentPhotoPickerController() {
        DispatchQueue.main.async {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        self.present(myPickerController, animated: true)
        }
    }
    
    @IBAction func addPhoto(_ sender: Any) {
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    self.presentPhotoPickerController()
                case .notDetermined:
                    self.presentPhotoPickerController()
                case .restricted:
                    let alert = UIAlertController(title: "Нет доступа к фото альбому", message: "Вы не сможете добавлять фото в программу", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                case .denied:
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Доступ к фото альбому был отклонён", message: "Вы не сможете добавлять фото в программу, пожалуйста, измените настройки", preferredStyle: .alert)
                        let goToSettingsAction = UIAlertAction(title: "Перейти в настройки", style: .default) { (action) in
                            //DispatchQueue.main.async {
                                let url = URL(string: UIApplication.openSettingsURLString)!
                                UIApplication.shared.open(url, options: [:])
                            //}
                        }
                        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
                        alert.addAction(goToSettingsAction)
                        alert.addAction(cancelButton)
                        self.present(alert, animated: true)
                    }
                @unknown default:
                    fatalError()
                }
            }
    }
    
    @IBAction func save(_ sender: Any) {
        
        clientTextField.rightViewMode = .never
        
        guard clientTextField.text != "", let newClientName = clientTextField.text else {
//            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
//            imageView.image = UIImage(systemName: "briefcase.fill")
//            imageView.contentMode = .scaleAspectFit
//            clientTextField.rightView = imageView
            
            clientTextField.placeholder = "Необходимо заполнить поле"
            
            clientTextField.layer.borderColor = UIColor.red.cgColor
            clientTextField.layer.cornerRadius = 5
            clientTextField.layer.borderWidth = 1
            
            clientTextField.rightViewMode = .always
            
            return
        }
        
        if let index = clientIndexToEdit {
            ClientsFunctions.updateClient(at: index, clientName: newClientName, image: carImageView.image)
        } else {
            ClientsFunctions.createClient(clientModel: ClientModel(clientName: newClientName, carImage: carImageView.image))
        }
        
        if let doneSaving = doneSaving {
            doneSaving()
        }
        dismiss(animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension AddClientViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.carImageView.image = image
        }
        dismiss(animated: true)
    }
}
