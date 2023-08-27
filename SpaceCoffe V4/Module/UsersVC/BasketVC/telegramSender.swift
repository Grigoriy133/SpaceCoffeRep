//
//  telegramSender.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 14.06.2023.
//

import Foundation

class telegramSender {
   static let shared = telegramSender()
    
    let token = "6264436309:AAHiS_0A9WvvUtSz3BzGDIaqBJn7PaA4XBI"
    let chatId = "923005721"

    func telegramRequest(message: String){
        let urlString = "https://api.telegram.org/bot6264436309:AAHiS_0A9WvvUtSz3BzGDIaqBJn7PaA4XBI/sendMessage?chat_id=790249601&text=\(message)"
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error sending message: \(error.localizedDescription)")
                } else if let data = data, let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        print("Message sent successfully!")
                    } else {
                        print("Error sending message: \(response.statusCode)")
                    }
                }
            }
            task.resume()
        }
    }
    func transform(order: order) -> String {
        let phoneUser = order.userPhone
        let ordersNumber = order.numberOrder
        var summ = Double(0)
        var stringName = "_"
        
        for prod in order.basket{
            summ += Double(prod.price) * promoKf
            stringName += "___" + prod.name + String(prod.capacity) + "_ml_________________"
        }
        let result = "clients_phone_Number_\(phoneUser)__________orders_Number_\(ordersNumber)_____________" + stringName + "Final_Wealth" + String(summ)
        print(promoKf)
        return result
    }
}

