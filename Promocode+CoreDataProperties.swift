//
//  Promocode+CoreDataProperties.swift
//  
//
//  Created by Grigoriy Korotaev on 25.06.2023.
//
//

import Foundation
import CoreData


extension Promocode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Promocode> {
        return NSFetchRequest<Promocode>(entityName: "Promocode")
    }

    @NSManaged public var key: String?
    @NSManaged public var value: Int64

}
