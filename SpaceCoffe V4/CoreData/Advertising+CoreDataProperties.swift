//
//  Advertising+CoreDataProperties.swift
//  
//
//  Created by Grigoriy Korotaev on 25.06.2023.
//
//

import Foundation
import CoreData


extension Advertising {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Advertising> {
        return NSFetchRequest<Advertising>(entityName: "Advertising")
    }

    @NSManaged public var image: Data?
    @NSManaged public var terms: String?

}
