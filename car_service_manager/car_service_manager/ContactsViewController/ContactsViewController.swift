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
    @IBOutlet weak var saveImage: UIImageView!
    @IBOutlet weak var menuView: GradientView!
    @IBOutlet weak var clientNameTextInput: UITextField!
    @IBOutlet weak var carTextField: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    var clientIndexToEdit: Int?
    var contacts = [Car]()
    
   // var searchContact = [String]()
    //var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        coreDataInitialSetup()
        makeTappableImage()
    }
    
    @IBAction func addToCoreData(_ sender: Any) {
        let name = clientNameTextInput.text!
        let carName = carTextField.text!
        let car = Car(context: PersistanceService.context)
        let png = self.saveImage.image?.pngData()
        car.carName = carName
        car.owner = name
        car.carImage = png
        
        PersistanceService.saveContext()
        self.contacts.append(car)
        self.contactsTableView.reloadData()
        toggleAddingMenu()
    }
    
    @IBAction func addNewClient() {
        toggleAddingMenu()
    }
}

// MARK: - Layout Extension
extension ContactsViewController {
    func configureLayout() {
        menuView.center = addButton.center
        menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }
    
    func toggleAddingMenu () {
        UIView.animate(withDuration: 0.3) {
        if self.menuView.transform == .identity {
            self.menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        } else {
            self.menuView.transform = .identity
        }
        }
    }
}

// MARK: - Core Data layout functions
extension ContactsViewController {
    func coreDataInitialSetup () {
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        do {
            let contacts = try PersistanceService.context.fetch(fetchRequest)
            self.contacts = contacts
            self.contactsTableView.reloadData()
        } catch {}
    }
}

// MARK: - Tappable Image Functions
extension ContactsViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func makeTappableImage () {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectImage(gesture:)))
        tapGesture.numberOfTouchesRequired = 1
        self.saveImage.isUserInteractionEnabled = true
        self.saveImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func selectImage(gesture: UITapGestureRecognizer) {
        self.openImagePicker()
    }
    
    func openImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let img = info[.originalImage] as? UIImage {
            self.saveImage.image = img
        }
    }
}

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactsCell") as! ClientTableViewCell
//        if searching {
//            cell.textLabel?.text = searchContact[indexPath.row]
//        } else {
        cell.carNameLabel.text = contacts[indexPath.row].owner
        cell.clientNameLabel.text = contacts[indexPath.row].carName
        
        if let imageData = contacts[indexPath.row].carImage {
            cell.clientImageView.image = UIImage(data: imageData)
        }
        //}
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
