//
//  ClientTableViewCell.swift
//  car_service_manager
//
//  Created by Anton Gaev on 17.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit

class ClientTableViewCell: UITableViewCell {

    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var clientImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clientImageView.layer.cornerRadius = clientImageView.frame.height/2
    }

//    func setup(model: ClientModel) {
//        carNameLabel.text = model.clientName
//        clientImageView.image = model.carImage
//    }
    
}
