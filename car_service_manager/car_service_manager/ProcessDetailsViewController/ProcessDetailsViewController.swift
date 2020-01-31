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
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var isUpdate = Bool()
    var car: Car?
    var repair: Repair?
    var subprocesses: [Subprocess]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subprocesses = DatabaseHelper.shareInstance.getSubprocessData(repair: repair)
        //subprocesses = DatabaseHelper.shareInstance.getSubprocessData(repair: nil)
        tableView.dataSource = self
        setUI()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        subprocesses = DatabaseHelper.shareInstance.getSubprocessData(repair: repair)
        //subprocesses = DatabaseHelper.shareInstance.getSubprocessData(repair: nil)
        tableView.reloadData()
    }
    
    func setUI() {
        if isUpdate {
            processNameTextField.text = repair?.processName
            //priceTextField.text = String(describing: repair!.price)
        }
    }
    
    @IBAction func saveClick(_ sender: Any) {
        let dict = ["processName": processNameTextField.text, "status": statusLabel.text, "price": priceTextField.text]
        if isUpdate {
            DatabaseHelper.shareInstance.editRepair(object: dict as! [String: String], i: repair!.id!)
        } else {
            DatabaseHelper.shareInstance.saveRepair(object: dict as! [String: String], car: car!)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addSubprocess(_ sender: Any) {
        let vc = UIStoryboard(name: "SubProcess", bundle: nil).instantiateInitialViewController() as! SubProcessTableViewController
        vc.repair = repair!
        vc.car = car!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProcessDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subprocesses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProcessDetailsTableViewCell
        cell.subprocessNameLabel.text = subprocesses![indexPath.row].name
        cell.statusLabel.text = subprocesses![indexPath.row].status
        return cell
    }
}
