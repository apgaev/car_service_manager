//
//  Repair+CoreDataProperties.swift
//  car_service_manager
//
//  Created by Anton Gaev on 30.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//
//

import Foundation
import CoreData


extension Repair {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repair> {
        return NSFetchRequest<Repair>(entityName: "Repair")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var photo: Data?
    @NSManaged public var processName: String?
    @NSManaged public var startingDate: Date?
    @NSManaged public var status: String?
    @NSManaged public var repairedCar: Car?
    @NSManaged public var subProcess: Subprocess?
    @NSManaged public var payment: Payment?

}
