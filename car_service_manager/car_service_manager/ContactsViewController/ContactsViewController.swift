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
    
    var clientIndexToEdit: Int?
    
    //var clientModel: ClientModel?
    
    var contacts = [Car]()
    
   // var searchContact = [String]()
    //var searching = false
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        do {
            let contacts = try PersistanceService.context.fetch(fetchRequest)
            self.contacts = contacts
            self.contactsTableView.reloadData()
        } catch {}
//        ClientsFunctions.readClient(completion: { [weak self] in
//            self?.contactsTableView.reloadData()
//        })
    }
    
//    @IBAction func unwindToContactsViewController(_ unwindSegue: UIStoryboardSegue) {
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddClientSegue" {
            let popup = segue.destination as! AddClientViewController
            popup.clientIndexToEdit = self.clientIndexToEdit
            popup.doneSaving = { [weak self] in
                self?.contactsTableView.reloadData()
            }
            clientIndexToEdit = nil
        }
    }
}

extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if searching {
            //return searchContact.count
        //} else {
            print(contacts.count)
            return contacts.count
            //return Data.clientModels.count
        //}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let model = clientModel!
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactsCell") as! ClientTableViewCell
//        if searching {
//            cell.textLabel?.text = searchContact[indexPath.row]
//        } else {
        cell.textLabel?.text = contacts[indexPath.row].carName
            //cell?.textLabel?.text = Data.clientModels[indexPath.row].clientName
        //}
        //cell.setup(model: Data.clientModels[indexPath.row])
        return cell
    }
}

//extension ContactsViewController: UITableViewDelegate {
//    
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
//    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: (Bool) -> ()) in
//            self.clientIndexToEdit = indexPath.row
//            self.performSegue(withIdentifier: "toAddClientSegue", sender: nil)
//            actionPerformed(true)
//        }
//        edit.image = UIImage.init(systemName: "pencil")
//        return UISwipeActionsConfiguration(actions: [edit])
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let client = Data.clientModels[indexPath.row]
//        
//        let storyboard = UIStoryboard(name: "Car", bundle: nil)
//        let vc = storyboard.instantiateInitialViewController() as! CarViewController
//        vc.clientId = client.id
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
//extension ContactsViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
////        searchContact = contacts.filter({$0.prefix(searchText.count) == searchText})
//        searching = true
//        contactsTableView.reloadData()
//    }
//}
