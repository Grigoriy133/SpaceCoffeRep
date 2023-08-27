//
//  Cafe+CoreDataProperties.swift
//  
//
//  Created by Grigoriy Korotaev on 25.06.2023.
//
//

import Foundation
import CoreData


extension Cafe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cafe> {
        return NSFetchRequest<Cafe>(entityName: "Cafe")
    }

    @NSManaged public var capacity: Int64
    @NSManaged public var image: Data?
    @NSManaged public var price: Int64
    @NSManaged public var name: String?

}
