//
//  Order.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 15.05.2023.
//

import Foundation

struct order{
    var userPhone = String()
    var dateOrder = Date()
    var numberOrder = String()
    var basket = [cafe]()
}
var lastOrderNumber = 0
let lastOrderKey = "lastOrderKey"
var orderStorage = [order]()
