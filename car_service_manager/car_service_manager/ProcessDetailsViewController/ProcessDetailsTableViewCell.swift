//
//  ProcessDetailsTableViewCell.swift
//  car_service_manager
//
//  Created by Anton Gaev on 30.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit

class ProcessDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var subprocessNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
