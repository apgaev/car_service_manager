//
//  DatabaseHelper.swift
//  car_service_manager
//
//  Created by Anton Gaev on 22.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DatabaseHelper {
    static let instance = DatabaseHelper()
    
    let context = PersistanceService.context
    
    func saveImageinCoredata(at imgData: Data) {
        var profile = NSEntityDescription.insertNewObject(forEntityName: "Car", into: context) as! Car
        profile.carImage = imgData
        do {
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func getAllImages() -> [Car] {
        var arrProfile = [Car]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Car")
        do {
            arrProfile = try context.fetch(fetchRequest) as! [Car]
        } catch let error {
            print(error.localizedDescription)
        }
        return arrProfile
    }
}
