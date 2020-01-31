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
    @IBOutlet weak var pastPaymentsTableView: UITableView!
    
    var payments = [Payment]()
    var repairs = [Repair]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        payments = DatabaseHelper.shareInstance.getPaymentData(car: nil, repair: nil, subprocess: nil)
//        repairs = DatabaseHelper.shareInstance.getRepairData(car: nil)
//        //repairs.map({debit = $0.price + debit})
//        marginLabel.text = String(describing: debit)
        pastPaymentsTableView.dataSource = self
        pastPaymentsTableView.reloadData()
    }
}

extension CashFlowsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pastPaymentsTableView.dequeueReusableCell(withIdentifier: "cell") as! PastTransactionsTableViewCell
        cell.transactionLabel.text = payments[indexPath.row].name
        cell.priceLabel.text = String(payments[indexPath.row].price)
        return cell
    }
}
