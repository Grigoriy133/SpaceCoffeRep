//
//  keyButton.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 13.05.2023.
//

import Foundation
import UIKit

public class keyButton {
    
    static let shared = keyButton()
    var view = UIView()
    
    func addDoneButtonOnKeyboard( textField : UITextField)
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action:  #selector(hideKeyboard))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        textField.inputAccessoryView = doneToolbar
    }
    @objc func hideKeyboard() {
       view.endEditing(true)
    }
}
