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

    @IBOutlet weak var contactsTableView: UITableView!

    var contacts = [Car]()
    var searchContacts = [Car]()
    var searchOwners = [Car]()
    var searchCars = [Car]()
    var searchNumbers = [Car]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contacts = DatabaseHelper.shareInstance.getCarData()
        searchContacts = contacts
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        contacts = DatabaseHelper.shareInstance.getCarData()
        searchContacts = contacts
        contactsTableView.reloadData()
    }
    
    @IBAction func toCreate(_ sender: Any) {
        let vc = UIStoryboard(name: "Car", bundle: nil).instantiateInitialViewController() as! CarViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ContactsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactsCell", for: indexPath) as! ClientTableViewCell
            cell.car = searchContacts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Удалить клиента", message: "Вы точно хотите удалить \(self.searchContacts[indexPath.row].carName!)?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: { (alertAction) in
                self.dismiss(animated: true)
            }))
            
            alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { (alertAction) in
                self.searchContacts = DatabaseHelper.shareInstance.deleteData(index: self.searchContacts[indexPath.row].id!)
                self.contactsTableView.deleteRows(at: [indexPath], with: .automatic)
            }))
            
            self.present(alert, animated: true)
        }
    }
}

extension ContactsViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Car", bundle: nil).instantiateInitialViewController() as! CarViewController
        vc.isUpdate = true
        let car = searchContacts[indexPath.row]
        vc.carDetails = car
        vc.indexRow = car.id
        self.navigationController?.pushViewController(vc, animated: true)
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
extension ContactsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchOwners = contacts.filter({ $0.owner!.prefix(searchText.count) == searchText})
        searchCars = contacts.filter({ $0.carName!.prefix(searchText.count) == searchText})
        searchNumbers = contacts.filter({ $0.phone!.prefix(searchText.count) == searchText})
        searchContacts = searchNumbers + searchCars + searchOwners
        searchContacts = Array(Set(searchContacts))
        searching = true
        contactsTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchContacts = contacts
        contactsTableView.reloadData()
    }
}
