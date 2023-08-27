//
//  Order+CoreDataProperties.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 16.05.2023.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var userPhone: String
    @NSManaged public var dateOrder: Date?
    @NSManaged public var numberOrder: String
    @NSManaged public var product1: NSSet?

}

// MARK: Generated accessors for product1
extension Order {

    @objc(addProduct1Object:)
    @NSManaged public func addToProduct1(_ value: Product)

    @objc(removeProduct1Object:)
    @NSManaged public func removeFromProduct1(_ value: Product)

    @objc(addProduct1:)
    @NSManaged public func addToProduct1(_ values: NSSet)

    @objc(removeProduct1:)
    @NSManaged public func removeFromProduct1(_ values: NSSet)

}

extension Order : Identifiable {

}
