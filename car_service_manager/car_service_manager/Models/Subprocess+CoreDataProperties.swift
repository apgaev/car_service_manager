//
//  Subprocess+CoreDataProperties.swift
//  car_service_manager
//
//  Created by Anton Gaev on 30.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//
//

import Foundation
import CoreData


extension Subprocess {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subprocess> {
        return NSFetchRequest<Subprocess>(entityName: "Subprocess")
    }

    @NSManaged public var endDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var status: String?
    @NSManaged public var mainProcess: Repair?
    @NSManaged public var payment: Payment?

}
