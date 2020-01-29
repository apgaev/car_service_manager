//
//  CarTableViewCell.swift
//  car_service_manager
//
//  Created by Anton Gaev on 19.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var repairNameLabel: UILabel!
    @IBOutlet weak var repairStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
