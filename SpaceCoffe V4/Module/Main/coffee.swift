//
//  Track.swift
//  factory
//
//  Created by Grigoriy Korotaev on 30.04.2023.
//

import Foundation

class coffe: cafe{
    var name: String = ""
    var capacity: Int = 0
    var image: String = ""
    var price: Int = 0
    
    init(name: String, capacity: Int, image: String, price: Int) {
        self.name = name
        self.capacity = capacity
        self.image = image
        self.price = price
    }
}
