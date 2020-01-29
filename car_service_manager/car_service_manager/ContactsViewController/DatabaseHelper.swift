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
            car.carNumber = object["number"]
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
        do {
            try context?.save()
        } catch {
            print("can not delete data")
        }
        return car
    }
    
    func editData(object: [String: String], image: Data, i: UUID, repairs: NSSet) {
        let car = getCarData()
        let theCar = car.filter({$0.id == i})
        theCar[0].carName = object["carName"]
        theCar[0].owner = object["owner"]
        theCar[0].phone = object["phone"]
        theCar[0].carImage = image
        theCar[0].carNumber = object["carNumber"]
        theCar[0].carRepairs = repairs
        do {
            try context?.save()
        } catch {
            print("can not delete data")
        }
    }
    
    func saveRepair(object: [String:String], car: Car) {
        let repair = NSEntityDescription.insertNewObject(forEntityName: "Repair", into: context!) as! Repair
        repair.id = UUID()
        repair.processName = object["processName"]
        repair.status = object["status"]
        repair.repairedCar = car
        do {
                try context?.save()
        } catch {
                print("data hasn't been saved")
        }
    }
    
    func getRepairData(car: Car?) -> [Repair] {
        var repair = [Repair]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Repair")
        do {
            repair = try context?.fetch(fetchRequest) as! [Repair]
            if let theCar = car {
                repair = repair.filter({$0.repairedCar == theCar})
            }
        } catch {
            print("can not get the data")
        }
        return repair
    }
    
    func deleteRepair(index: UUID, car: Car) -> [Repair] {
        var repair = getRepairData(car: car)
        let theRepair = repair.filter({$0.id == index})
        context?.delete(theRepair[0])
        repair = repair.filter({$0.id != index})
        do {
            try context?.save()
        } catch {
            print("can not delete data")
        }
        return repair
    }
    
    func editRepair(object: [String: String], i: UUID) {
        let repair = getRepairData(car: nil)
        let theRepair = repair.filter({$0.id == i})
        theRepair[0].processName = object["processName"]
        theRepair[0].status = object["status"]
        //theRepair[0].repairedCar = car
        do {
            try context?.save()
        } catch {
            print("can not delete data")
        }
    }
}
