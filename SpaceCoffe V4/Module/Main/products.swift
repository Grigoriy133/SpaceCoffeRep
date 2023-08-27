//
//  ProvideFunc.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 12.05.2023.
//

import Foundation

public class products {
    static let shared = products()
    var arrayCafe = [cafe]()
    func createCafeElement(vname: cafeType, name: String, capacity: Int?, image: String?, price: Int) {
        var newCafe = Factory.factoryDefault.provide(type: vname)
        newCafe = coffe(name: name, capacity: capacity ?? 0, image: image ?? "", price: price)
        arrayCafe.append(newCafe)
    }
}
