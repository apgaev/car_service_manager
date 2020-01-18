//
//  ClientsFunctions.swift
//  car_service_manager
//
//  Created by Anton Gaev on 17.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit

class ClientsFunctions {
    
    static func createClient(clientModel: ClientModel) {
        Data.clientModels.append(clientModel)
    }
    
    static func readClient(completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            if Data.clientModels.count == 0 {
                Data.clientModels.append(ClientModel(clientName: "Антон Гаев"))
                Data.clientModels.append(ClientModel(clientName: "Антон Иванов"))
                Data.clientModels.append(ClientModel(clientName: "Игорь Назаренко"))
            }
        }
        DispatchQueue.main.async {
            completion()
        }
    }
    
    static func updateClient(at index: Int, clientName: String, image: UIImage? = nil) {
        Data.clientModels[index].clientName = clientName
        Data.clientModels[index].carImage = image
    }
     
    static func deleteClient(index: Int) {
        Data.clientModels.remove(at: index)
    }
}
