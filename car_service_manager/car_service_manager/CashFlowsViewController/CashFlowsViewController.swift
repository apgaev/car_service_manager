//
//  CashFlowsViewController.swift
//  car_service_manager
//
//  Created by Anton Gaev on 30.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit

class CashFlowsViewController: UIViewController {

    
    @IBOutlet weak var costsView: UIView!
    @IBOutlet weak var debitView: UIView!
    @IBOutlet weak var marginLabel: UILabel!
    
    var debit = Int32(0)
    var repairs = [Repair]()
    var costs = Int32(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repairs = DatabaseHelper.shareInstance.getRepairData(car: nil)
        repairs.map({debit = $0.price + debit})
        marginLabel.text = String(describing: debit)
    }
}
