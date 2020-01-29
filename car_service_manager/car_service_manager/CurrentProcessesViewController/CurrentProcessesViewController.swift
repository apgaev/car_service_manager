//
//  CurrentProcessesViewController.swift
//  car_service_manager
//
//  Created by Anton Gaev on 29.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit

class CurrentProcessesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var repairs = [Repair]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repairs = DatabaseHelper.shareInstance.getRepairData(car: nil)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        repairs = DatabaseHelper.shareInstance.getRepairData(car: nil)
        tableView.reloadData()
    }
}

extension CurrentProcessesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repairs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrentProcessesTableViewCell
        cell.process = repairs[indexPath.row]
        return cell
    }
}

extension CurrentProcessesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "ProcessDetails", bundle: nil).instantiateInitialViewController() as! ProcessDetailsViewController
        vc.isUpdate = true
        vc.repair = repairs[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
