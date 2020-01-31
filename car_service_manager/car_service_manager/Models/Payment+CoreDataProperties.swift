//
//  Payment+CoreDataProperties.swift
//  car_service_manager
//
//  Created by Anton Gaev on 30.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//
//

import Foundation
import CoreData


extension Payment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Payment> {
        return NSFetchRequest<Payment>(entityName: "Payment")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var price: Int32
    @NSManaged public var status: String?
    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var subprocess: Subprocess?
    @NSManaged public var repair: Repair?
    @NSManaged public var car: Car?

}
