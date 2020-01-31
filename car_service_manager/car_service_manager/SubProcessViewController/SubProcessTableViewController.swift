//
//  SubProcessTableViewController.swift
//  car_service_manager
//
//  Created by Anton Gaev on 30.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit
import CoreData

class SubProcessTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    var statusIsOn = false
    var startIsOn = false
    var endIsOn = false
    let dateFormatter = DateFormatter()
    var car: Car?
    var repair: Repair?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveSubProcess))
    }

    @objc func saveSubProcess() {
        let subprocess = NSEntityDescription.insertNewObject(forEntityName: "Subprocess", into: DatabaseHelper.shareInstance.context!) as! Subprocess
        subprocess.id = UUID()
        subprocess.name         = nameTextField.text!
        subprocess.status       = statusLabel.text!
        subprocess.endDate      = endDatePicker.date
        //subprocess.notes      = object["notes"]
        subprocess.startDate    = startDatePicker.date
        subprocess.mainProcess  = repair
        
        let dict = ["name": nameTextField.text!, "status": statusLabel.text!]
        
        DatabaseHelper.shareInstance.savePayment(object: dict, price: Int32(Int(priceTextField.text!)!), car: car!, date: endDatePicker.date, repair: repair!, subprocess: subprocess)
//        DatabaseHelper.shareInstance.saveSubprocess(object: dict, car: car!, startDate: startDatePicker.date, endDate: endDatePicker.date, repair: repair!, payment: nil)
    }
    
// MARK: - Selections
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 2 {
                statusIsOn = toggleStatusSection(switch: statusIsOn)
                tableView.reloadSections([1], with: .automatic)
            }
        } else if indexPath.section == 1 {
            statusSwitcher(row: indexPath)
            statusIsOn = toggleStatusSection(switch: statusIsOn)
            tableView.reloadSections([1], with: .automatic)
        } else if indexPath.section == 2 {
            startIsOn = toggleStatusSection(switch: startIsOn)
            tableView.reloadSections([3], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            if statusIsOn == false {
                return 0
            } else {
                return 3
            }
        }
        if section == 3 {
            if startIsOn == false {
                return 0
            } else {
                return 1
            }
        }
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func toggleStatusSection(switch selectedSwitcher: Bool) -> Bool {
        if selectedSwitcher == false {
            return true
        } else {
            return false
        }
    }
    
    func statusSwitcher(row: IndexPath) {
        for i in 0...2 {
            tableView.cellForRow(at: [1,i])?.accessoryType = UITableViewCell.AccessoryType.none
        }
        tableView.cellForRow(at: row)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        statusLabel.text = tableView.cellForRow(at: row)?.textLabel!.text
    }
    
    // MARK: - Table view data source
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func startDatePickerAction(_ sender: Any) {
        dateFormatter.dateFormat = "dd MMMM yyyy"
        startDateLabel.text = dateFormatter.string(from: startDatePicker.date)
    }
}
