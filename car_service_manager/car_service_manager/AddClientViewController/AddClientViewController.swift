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
        ClientsFunctions.createClient(clientModel: ClientModel(clientName: clientTextField.text!))
        
        if let doneSaving = doneSaving {
            doneSaving()
        }
        dismiss(animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
}
