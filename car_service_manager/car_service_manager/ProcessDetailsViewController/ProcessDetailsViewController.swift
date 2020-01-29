//
//  ProcessDetailsViewController.swift
//  car_service_manager
//
//  Created by Anton Gaev on 17.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit

class ProcessDetailsViewController: UIViewController {

    @IBOutlet weak var processNameTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    var isUpdate = Bool()
    var car: Car?
    var repair: Repair?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        if isUpdate {
            processNameTextField.text = repair?.processName
        }
    }
    
    @IBAction func saveClick(_ sender: Any) {
        let dict = ["processName": processNameTextField.text, "status": statusLabel.text]
        if isUpdate {
            DatabaseHelper.shareInstance.editRepair(object: dict as! [String: String], car: car!, i: repair!.id!)
        } else {
            DatabaseHelper.shareInstance.saveRepair(object: dict as! [String: String], car: car!)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
