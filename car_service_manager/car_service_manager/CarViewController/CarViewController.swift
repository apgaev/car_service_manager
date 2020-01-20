//
//  CarViewController.swift
//  car_service_manager
//
//  Created by Anton Gaev on 17.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    //var clientId: UUID!
    //var clientModel: ClientModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
//        ClientsFunctions.readContact(by: clientId) { [weak self] (model) in
//            guard let self = self else { return }
//            self.clientModel = model
//
//            guard let model = model else { return }
//            self.title = model.clientName
//            self.backgroundImageView.image = model.carImage
//
//            self.tableView.reloadData()
//        }
    }
}

extension CarViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
        //return Data.clientModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var model = Data.clientModels[indexPath.row].clientName
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CarTableViewCell
        //cell.setup(model: CarModel)
        return cell
    }
}
