//
//  ContactsViewController.swift
//  car_service_manager
//
//  Created by Anton Gaev on 16.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {

    @IBOutlet weak var contactsSearchBar: UISearchBar!
    @IBOutlet weak var contactsTableView: UITableView!
    
    //var clientModel: ClientModel?
    
    //let contacts = ["Антон Гаев", "Антон Иванов", "Игорь Назаренко"]
    
    //var searchContact = [String]()
    //var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ClientsFunctions.readClient(completion: { [weak self] in
            self?.contactsTableView.reloadData()
        })
    }
}

extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if searching {
            //return searchContact.count
        //} else {
            //return contacts.count
            return Data.clientModels.count
        //}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let model = clientModel!
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactsCell") as! ClientTableViewCell
//        if searching {
//            cell?.textLabel?.text = searchContact[indexPath.row]
//        } else {
//            //cell?.textLabel?.text = contacts[indexPath.row]
//            cell?.textLabel?.text = Data.clientModels[indexPath.row].clientName
//        }
        cell.setup(model: Data.clientModels[indexPath.row])
        return cell
    }
}

//extension ContactsViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        //searchContact = contacts.filter({$0.prefix(searchText.count) == searchText})
//        searching = true
//        contactsTableView.reloadData()
//    }
//}
