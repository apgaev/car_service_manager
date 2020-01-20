//
//  Repairs+CoreDataProperties.swift
//  car_service_manager
//
//  Created by Anton Gaev on 20.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//
//

import Foundation
import CoreData


extension Repairs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repairs> {
        return NSFetchRequest<Repairs>(entityName: "Repairs")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var status: String?
    @NSManaged public var processName: String?
    @NSManaged public var repairedCar: Car?

}
