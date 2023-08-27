//
//  Constants.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 22.05.2023.
//

import UIKit

    var kf = CGFloat()
    var backgroundColorMain = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1)
    var buttonsGreenColor = UIColor(red: 99/255, green: 218/255, blue: 110/255, alpha: 1)
    var lightGreenColor = UIColor(red: 16/255, green: 244/255, blue: 241/255, alpha: 1)
    var pinkColor = UIColor(red: 237/255, green: 50/255, blue: 102/255, alpha: 1)
    var secondBlackColor = UIColor(red: 33/255, green: 43/255, blue: 48/255, alpha: 1)
    
class reusableFunction{
    static let shared = reusableFunction()
    
    func summonAlertConroller(title: String, message: String?) -> UIAlertController {
        let newAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Окей", style: .cancel)
        newAlert.addAction(cancelButton)
        return newAlert
    }
}
