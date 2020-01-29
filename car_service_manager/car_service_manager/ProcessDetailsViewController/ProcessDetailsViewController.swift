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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveClick(_ sender: Any) {
        let dict = ["processName": processNameTextField.text, "status": statusLabel.text]
        //let png = self.saveImage.image?.pngData()
        if isUpdate {
            //DatabaseHelper.shareInstance.editData(object: dict as! [String: String], image: png!,  i: indexRow!)
        } else {
            DatabaseHelper.shareInstance.saveRepair(object: dict as! [String: String], car: car!)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
