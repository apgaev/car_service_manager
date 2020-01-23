//
//  ProcessDetailsViewController.swift
//  car_service_manager
//
//  Created by Anton Gaev on 17.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit

class ProcessDetailsViewController: UIViewController {

    @IBOutlet weak var dummyTextField: UITextField!
    
    var onSave: ((_ data: String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func returnWithSomeDataToContactsViewController(_ sender: Any) {
            onSave?(dummyTextField.text!)
            dismiss(animated: true)
        }
}
