//
//  Car+CoreDataProperties.swift
//  car_service_manager
//
//  Created by Anton Gaev on 29.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var carImage: Data?
    @NSManaged public var carName: String?
    @NSManaged public var carNumber: String?
    @NSManaged public var id: UUID?
    @NSManaged public var owner: String?
    @NSManaged public var phone: String?
    @NSManaged public var carRepairs: NSSet?

}

// MARK: Generated accessors for carRepairs
extension Car {

    @objc(addCarRepairsObject:)
    @NSManaged public func addToCarRepairs(_ value: Repair)

    @objc(removeCarRepairsObject:)
    @NSManaged public func removeFromCarRepairs(_ value: Repair)

    @objc(addCarRepairs:)
    @NSManaged public func addToCarRepairs(_ values: NSSet)

    @objc(removeCarRepairs:)
    @NSManaged public func removeFromCarRepairs(_ values: NSSet)

}
