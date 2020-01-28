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
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var carNumberLabel: UILabel!
    
    var car: Car! {
        didSet {
            carNameLabel.text = car.carName
            clientNameLabel.text = car.owner
            carNumberLabel.text = car.phone
            if let theImage = car.carImage {
                clientImageView.image = UIImage(data: theImage)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clientImageView.layer.cornerRadius = clientImageView.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
