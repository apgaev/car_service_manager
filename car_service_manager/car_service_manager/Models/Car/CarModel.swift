//
//  CarModel.swift
//  car_service_manager
//
//  Created by Anton Gaev on 17.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit

struct CarModel {
    let id: UUID
    
    var carName: String
    //var carPhoto: [UIImage]?
    //var carNotes: String?
    //var brokenParts: [String]?
    
    init(carName: String) {
        id = UUID()
        
        self.carName = carName
    }
}
