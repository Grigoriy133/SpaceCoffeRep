//
//  User.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 13.05.2023.
//

import Foundation

struct user{
    var userType = Bool()
    var password = String()
    var phone = String()
    var id = Int()
    var registrationDate = Date()
}

var localUserStorage = [user(userType: false, password: "12", phone: "12", id: 12, registrationDate: Date()), user(userType: true, password: "77", phone: "77", id: 0, registrationDate: Date())]
var localUsersPasswordDictionary = [String:String]()
