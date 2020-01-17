//
//  AddClientViewController.swift
//  car_service_manager
//
//  Created by Anton Gaev on 17.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit

class AddClientViewController: UIViewController {

    @IBOutlet weak var addClientPopupView: UIView!
    @IBOutlet weak var clientTextField: UITextField!
    
    var doneSaving : (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addClientPopupView.addShadowAndRoundedCorners()
    }
    
    @IBAction func save(_ sender: Any) {
        
        clientTextField.rightViewMode = .never
        
        guard clientTextField.text != "", let newClientName = clientTextField.text else {
//            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
//            imageView.image = UIImage(systemName: "briefcase.fill")
//            imageView.contentMode = .scaleAspectFit
//            clientTextField.rightView = imageView
            
            clientTextField.layer.borderColor = UIColor.red.cgColor
            clientTextField.layer.borderWidth = 1
            clientTextField.layer.cornerRadius = 5
            
            clientTextField.placeholder = "Необходимо заполнить поле"
            
            clientTextField.rightViewMode = .always
            
            return
        }
        
        ClientsFunctions.createClient(clientModel: ClientModel(clientName: newClientName))
        
        if let doneSaving = doneSaving {
            doneSaving()
        }
        dismiss(animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
}
