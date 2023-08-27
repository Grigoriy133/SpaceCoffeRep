//
//  Factory.swift
//  factory
//
//  Created by Grigoriy Korotaev on 30.04.2023.
//

import Foundation

enum cafeType{
case coffe
}

class Factory {
    static let factoryDefault = Factory()
    
    func provide(type: cafeType) -> cafe {
        switch type{
        case .coffe: return coffe(name: "", capacity: 0, image: "", price: 0)
        }
    }
}
