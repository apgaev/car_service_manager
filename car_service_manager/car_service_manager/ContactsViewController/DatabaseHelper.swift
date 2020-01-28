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
            car.id = UUID()
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
    
    func deleteData(index: UUID) -> [Car] {
        var car = getCarData()
        let theCar = car.filter({$0.id == index})
        context?.delete(theCar[0])
        car = car.filter({$0.id != index})
        //car.remove(theCar[0])
        do {
            try context?.save()
        } catch {
            print("can not delete data")
        }
        return car
    }
    
    func editData(object: [String: String], image: Data, i: UUID) {
        let car = getCarData()
        let theCar = car.filter({$0.id == i})
        theCar[0].carName = object["carName"]
        theCar[0].owner = object["owner"]
        theCar[0].phone = object["phone"]
        theCar[0].carImage = image
        do {
            try context?.save()
        } catch {
            print("can not delete data")
        }
    }
}
