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
        //repair.price = Int32(object["price"]!)!
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
        //theRepair[0].price = Int32(object["price"]!)!
        do {
            try context?.save()
        } catch {
            print("can not delete data")
        }
    }
    
    func saveSubprocess(object: [String:String], car: Car, startDate: Date, endDate: Date, repair: Repair, payment: Payment?) {
        let subprocess = NSEntityDescription.insertNewObject(forEntityName: "Subprocess", into: context!) as! Subprocess
        subprocess.id = UUID()
        subprocess.name = object["name"]
        subprocess.status = object["status"]
        subprocess.endDate = endDate
        subprocess.notes = object["notes"]
        subprocess.startDate = startDate
        subprocess.mainProcess = repair
        subprocess.payment = payment
        do {
                try context?.save()
        } catch {
                print("data hasn't been saved")
        }
    }
    
    func getSubprocessData(repair: Repair?) -> [Subprocess] {
        var subprocess = [Subprocess]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Subprocess")
        do {
            subprocess = try context?.fetch(fetchRequest) as! [Subprocess]
            if let theRepair = repair {
                subprocess = subprocess.filter({$0.mainProcess == theRepair})
            }
        } catch {
            print("can not get the data")
        }
        return subprocess
    }
    
    func deleteSubprocess(index: UUID, repair: Repair) -> [Subprocess] {
        var subprocess = getSubprocessData(repair: repair)
        let theSubprocess = subprocess.filter({$0.id == index})
        context?.delete(theSubprocess[0])
        //repair = repair.filter({$0.id != index})
        do {
            try context?.save()
        } catch {
            print("can not delete data")
        }
        return subprocess
    }
    
    func editSubprocess(object: [String: String], i: UUID) {
        let repair = getSubprocessData(repair: nil)
//        let theRepair = repair.filter({$0.id == i})
//        theRepair[0].processName = object["processName"]
//        theRepair[0].status = object["status"]
        //theRepair[0].price = Int32(object["price"]!)!
        do {
            try context?.save()
        } catch {
            print("can not delete data")
        }
    }
    
    func savePayment(object: [String:String], price: Int32, car: Car, date: Date, repair: Repair, subprocess: Subprocess) {
            let payment = NSEntityDescription.insertNewObject(forEntityName: "Payment", into: context!) as! Payment
            payment.id = UUID()
            payment.name = object["name"]
            payment.status = object["status"]
            payment.date = date
            payment.price = price
            payment.car = car
            payment.repair = repair
            payment.subprocess = subprocess
            do {
                    try context?.save()
            } catch {
                    print("data hasn't been saved")
            }
        }
        
    func getPaymentData(car: Car?, repair: Repair?, subprocess: Subprocess?) -> [Payment] {
            var payment = [Payment]()
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Payment")
            do {
                payment = try context?.fetch(fetchRequest) as! [Payment]
                if let theCar = car {
                    payment = payment.filter({$0.car == theCar})
                }
                if let theRepair = repair {
                    payment = payment.filter({$0.repair == theRepair})
                }
                if let theSubprocess = subprocess {
                    payment = payment.filter({$0.subprocess == theSubprocess})
                }
            } catch {
                print("can not get the data")
            }
            return payment
        }
        
        func deletePayment(index: UUID) -> [Payment] {
            var payment = getPaymentData(car: nil, repair: nil, subprocess: nil)
            let thePayment = payment.filter({$0.id == index})
            context?.delete(thePayment[0])
            payment = payment.filter({$0.id != index})
            do {
                try context?.save()
            } catch {
                print("can not delete data")
            }
            return payment
        }
        
        func editPayment(object: [String: String], i: UUID) {
            let payment = getPaymentData(car: nil, repair: nil, subprocess: nil)
    //        let theRepair = repair.filter({$0.id == i})
    //        theRepair[0].processName = object["processName"]
    //        theRepair[0].status = object["status"]
            //theRepair[0].price = Int32(object["price"]!)!
            do {
                try context?.save()
            } catch {
                print("can not delete data")
            }
        }

}
