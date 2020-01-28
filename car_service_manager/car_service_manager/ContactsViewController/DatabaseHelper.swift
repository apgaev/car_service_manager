//
//  DatabaseHelper.swift
//  car_service_manager
//
//  Created by Anton Gaev on 28.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    
    static var shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func save(object: [String:String], image: Data) {
            let car = NSEntityDescription.insertNewObject(forEntityName: "Car", into: context!) as! Car
            car.carName = object["carName"]
            car.owner = object["owner"]
            car.phone = object["phone"]
            car.carImage = image
            do {
                try context?.save()
            } catch {
                print("data hasn't been saved")
            }
    }
    
    func getCarData() -> [Car] {
        var car = [Car]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Car")
        
        do {
            car = try context?.fetch(fetchRequest) as! [Car]
        } catch {
            print("can not get the data")
        }
        return car
    }
    
    func deleteData(index: Int) -> [Car] {
        var car = getCarData()
        context?.delete(car[index])
        car.remove(at: index)
        do {
            try context?.save()
        } catch {
            print("can not delete data")
        }
        return car
    }
    
    func editData(object: [String: String], image: Data, i: Int) {
        let car = getCarData()
        
        car[i].carName = object["carName"]
        car[i].owner = object["owner"]
        car[i].phone = object["phone"]
        car[i].carImage = image
        do {
            try context?.save()
        } catch {
            print("can not delete data")
        }
    }
}
