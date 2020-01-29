//
//  CurrentProcessesTableViewCell.swift
//  car_service_manager
//
//  Created by Anton Gaev on 29.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit

class CurrentProcessesTableViewCell: UITableViewCell {

    @IBOutlet weak var processImage: UIImageView!
    @IBOutlet weak var processLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var process: Repair! {
        didSet {
            processLabel.text = process.processName
            statusLabel.text = process.status
//            if let theImage = process {
//                processImage.image = UIImage(data: theImage)
//            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
