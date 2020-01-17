//
//  ClientModel.swift
//  car_service_manager
//
//  Created by Anton Gaev on 17.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit

struct ClientModel {
    let id: UUID
    var clientName: String
    
    //var car: CarModel
    
    //init(car: CarModel, clientName: String? = nil) {
    init(clientName: String) {
        id = UUID()
        //self.car = car

        self.clientName = clientName
    }
}
