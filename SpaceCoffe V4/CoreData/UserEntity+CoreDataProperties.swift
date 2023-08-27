//
//  UserEntity+CoreDataProperties.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 16.05.2023.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var password: String?
    @NSManaged public var userType: Bool
    @NSManaged public var userId: Int64
    @NSManaged public var registrationDate: Date?
    @NSManaged public var phone: String

}

extension UserEntity : Identifiable {

}
