//
//  PastTransactionsTableViewCell.swift
//  car_service_manager
//
//  Created by Anton Gaev on 01.02.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit

class PastTransactionsTableViewCell: UITableViewCell {

    @IBOutlet weak var transactionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
