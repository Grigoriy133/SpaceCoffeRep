//
//  Product+CoreDataProperties.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 16.05.2023.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var capacity: Int64
    @NSManaged public var name: String?
    @NSManaged public var price: Int64
    @NSManaged public var image: String?
    @NSManaged public var order1: Order?

}

extension Product : Identifiable {

}
