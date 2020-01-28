//
//  ContactsViewController.swift
//  car_service_manager
//
//  Created by Anton Gaev on 16.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit
import CoreData

class ContactsViewController: UIViewController {

    @IBOutlet weak var contactsSearchBar: UISearchBar!
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchOptions: UIButton!
    
//    var carToEdit: Car?
    var contacts = [Car]()
    
   // var searchContact = [String]()
    //var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contacts = DatabaseHelper.shareInstance.getCarData()
        
        //configureLayout()
//        coreDataInitialSetup()
//        carToEdit = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCarViewController" {
            let destVC = segue.destination as! CarViewController
            
            destVC.carToEdit = (sender as? [Car: Int])!
            destVC.isUpdate = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        contacts = DatabaseHelper.shareInstance.getCarData()
        contactsTableView.reloadData()
    }
    
    @IBAction func toCreate(_ sender: Any) {
        let vc = UIStoryboard(name: "Car", bundle: nil).instantiateInitialViewController() as! CarViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
//        let carVC = storyboard?.instantiateViewController(identifier: "CarViewController") as! CarViewController
//        self.navigationController?.pushViewController(carVC, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toCarViewController" {
//            let popup = segue.destination as! CarViewController
//            popup.carToEdit = self.carToEdit
//            popup.onSave = { (data) in
//                PersistanceService.context.perform {
//                    let name = data.owner
//                    let carName = data.carName
//                    let car = Car(context: PersistanceService.context)
//                    let png = data.carImage
//                    car.carName = carName
//                    car.owner = name
//                    car.carImage = png
//                    car.phone = data.phone
//                    car.id = data.id
//                    if self.carToEdit == nil {
//                        DispatchQueue.main.async {
//                            self.contacts.append(car)
//                        }
//                    }
//                    DispatchQueue.main.async {
//                        self.contactsTableView.reloadData()
//                    }
//                    PersistanceService.saveContext()
//                }
//            }
//            self.carToEdit = nil
//        }
//    }
    
//    @IBAction func addNewClient() {
//        toggleAddingMenu()
//    }
}

// MARK: - Layout Extension
//extension ContactsViewController {
//    func configureLayout() {
//        menuView.center = addButton.center
//        menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//    }
//
//    func toggleAddingMenu () {
//        UIView.animate(withDuration: 0.3) {
//        if self.menuView.transform == .identity {
//            self.menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//        } else {
//            self.menuView.transform = .identity
//        }
//        }
//    }
//}

// MARK: - Core Data layout functions
//extension ContactsViewController {
//    func coreDataInitialSetup () {
//        //loads initially
//        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
//        do {
//            let contacts = try PersistanceService.context.fetch(fetchRequest)
//            self.contacts = contacts
//            self.contactsTableView.reloadData()
//        } catch {}
//    }
//}

// MARK: - TableView Extensions
extension ContactsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if searching {
            //return searchContact.count
        //} else {
            return contacts.count
        //}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactsCell", for: indexPath) as! ClientTableViewCell
//        if searching {
//            cell.textLabel?.text = searchContact[indexPath.row]
//        } else {
//        cell.carNameLabel.text = self.contacts[indexPath.row].owner
//        cell.clientNameLabel.text = self.contacts[indexPath.row].carName
//
//        if let imageData = self.contacts[indexPath.row].carImage {
//            cell.clientImageView.image = UIImage(data: imageData)
//        }
        cell.car = contacts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts = DatabaseHelper.shareInstance.deleteData(index: indexPath.row)
            self.contactsTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
//
extension ContactsViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = contacts[indexPath.row]
        let i = indexPath.row
        let senderDict = [car: i] as [Car: Int]
        performSegue(withIdentifier: "toCarViewController", sender: senderDict)
//        self.carToEdit = car
//        self.performSegue(withIdentifier: "toCarViewController", sender: nil)
        //actionPerformed(true)
    }
    
    // MARK: - Swiping actions
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let client = Data.clientModels[indexPath.row]
//
//        let delete = UIContextualAction(style: .destructive, title: "Удалить") { (contextualAction, view, actionPerformed: @escaping (Bool) -> ()) in
//
//            let alert = UIAlertController(title: "Удалить клиента", message: "Вы точно хотите удалить клиента \(client.clientName)?", preferredStyle: .alert)
//
//            alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: { (alertAction) in
//                actionPerformed(false)
//            }))
//
//            alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { (alertAction) in
//                ClientsFunctions.deleteClient(index: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//            }))
//
//            self.present(alert, animated: true)
//        }
//        delete.image = UIImage.init(systemName: "delete.left.fill")
//        return UISwipeActionsConfiguration(actions: [delete])
//    }
    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: (Bool) -> ()) in
//            let car = self.contacts[indexPath.row]
//            self.clientIDToEdit = car.id
//            print("in extension \(self.clientIDToEdit)")
//            self.performSegue(withIdentifier: "toCarViewController", sender: nil)
//            actionPerformed(true)
//        }
//        edit.image = UIImage.init(systemName: "pencil")
//        return UISwipeActionsConfiguration(actions: [edit])
//    }
}
//
//extension ContactsViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
////        searchContact = contacts.filter({$0.prefix(searchText.count) == searchText})
//        searching = true
//        contactsTableView.reloadData()
//    }
//}
