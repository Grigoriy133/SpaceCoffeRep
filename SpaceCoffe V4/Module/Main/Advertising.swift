//
//  Advertising&Products.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 29.05.2023.
//

import UIKit

struct advertisingStruct{
    var image = UIImage()
    var terms = String()
}


var AdvertisingArray = [advertisingStruct(image: UIImage(named: "sixthCup") ?? UIImage(), terms: "Купи 5 кружек и получи скидку 99% на 6ю, акция распространяется в заведениях быстрого питания SpaceCoffee, продавец вправе досрочно завершить акцию без оповещения потребителя, акция действует до 22.12.2030"), advertisingStruct(image: UIImage(named: "sixthCup") ?? UIImage(), terms: "Купи 5 кружен и получи скидку 99% на 6ю, акция распространяется в заведениях быстрого питания SpaceCoffee, продавец вправе досрочно завершить акцию без оповещения потребителя, акция действует до 22.12.2030")]
var generalAdvertisingArray = [advertisingStruct]()
