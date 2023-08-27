//
//  funcLoadData.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 15.05.2023.
//

import Foundation
import CoreData
import UIKit

class DataClass {
    static let share = DataClass()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // MARK: - User Data functional
    func loadUsersFromStorage(){
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let featchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
              do {
            let results = try context.fetch(featchRequest)
            for result in results as! [UserEntity] {
                let newUser = user(userType: result.userType, password: result.password ?? "", phone: result.phone, id: Int(result.userId), registrationDate: result.registrationDate ?? Date())
                localUserStorage.append(newUser)
            }
        } catch {
            print("error with featch DATA")
        }
        for user1 in localUserStorage {
            localUsersPasswordDictionary[user1.password] = user1.phone
        }
    }
    func saveUser(newUser: user){

        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "UserEntity", in: context)
        let managedObject = UserEntity(entity: entityDescription!, insertInto: context)
        managedObject.phone = newUser.phone
        managedObject.registrationDate = newUser.registrationDate
        managedObject.userType = newUser.userType
        managedObject.password = newUser.password
        managedObject.userId = Int64(newUser.id)
        appDelegate.saveContext()
       
    }
// MARK: - Order Data functional
    // MARK: Save Order information
    func saveOrder(arrayProducts: [cafe], userPhone: String, dateOrder: Date, numberOrder: String){
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let products = loadProductsToOrder(arrayProducts: arrayProducts)
        
        let entityDescription2 = NSEntityDescription.entity(forEntityName: "Order", in: context)
        let managedObject2 = Order(entity: entityDescription2!, insertInto: context)
        
        for product in products {
            managedObject2.addToProduct1(product)
        }
        
        managedObject2.userPhone = userPhone
        managedObject2.dateOrder = dateOrder
        managedObject2.numberOrder = numberOrder
        
        appDelegate.saveContext()
    }
    
    func loadProductsToOrder(arrayProducts: [cafe]) -> [Product] {
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        var products: [Product] = []
        
        for product in arrayProducts {
            let entityDescription = NSEntityDescription.entity(forEntityName: "Product", in: context)
            let managedObject = Product(entity: entityDescription!, insertInto: context)
            managedObject.name = product.name
            managedObject.capacity = Int64(product.capacity)
            managedObject.image = product.image
            managedObject.price = Int64(product.price)
            
            products.append(managedObject)
        }
        
        appDelegate.saveContext()
        return products
    }

    
    // MARK: Load user information
    func loadOrders(){
        orderStorage = [order]()
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let featchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
              do {
            let results = try context.fetch(featchRequest)
                  for result in results as! [Order] {
                      var newOrder = order()
                      if let products = result.product1?.allObjects as? [Product] {
                          var newProductsArray = [cafe]()
                          for product in products {
                              let newProduct = coffe(name: product.name ?? "", capacity: Int(product.capacity), image: product.image ?? "", price: Int(product.price))
                              newProductsArray.append(newProduct)
                              print(newProductsArray.count)
                          }
                          newOrder.basket = newProductsArray
                          newOrder.numberOrder = result.numberOrder
                          newOrder.userPhone = result.userPhone
                          newOrder.dateOrder = result.dateOrder ?? Date()
                      }
                      orderStorage.append(newOrder)
                  }
        } catch {
            print("error with featch DATA")
        }
    }
    func saveAdvertising(image: UIImage, text: String){
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Advertising", in: context)
        let newItem = NSManagedObject(entity: entity!, insertInto: context)
            
            let imageData = image.pngData()
            newItem.setValue(imageData, forKey: "image")
            newItem.setValue(text, forKey: "terms")
            
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
    }
    func loadAdvertising(){
        generalAdvertisingArray = [advertisingStruct]()
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let featchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Advertising")
        do {
               let results = try context.fetch(featchRequest)
               for result in results as! [NSManagedObject] {
                   if let imageData = result.value(forKey: "image") as? Data,
                       let image = UIImage(data: imageData),
                       let text = result.value(forKey: "terms") as? String {
                       generalAdvertisingArray.append(advertisingStruct(image: image, terms: text))
                   }
               }
           } catch {
               print("Failed loading")
           }
        generalAdvertisingArray += AdvertisingArray
    }
    func deleteAdverising(text: String){
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let featchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Advertising")
            featchRequest.predicate = NSPredicate(format: "terms = %@", text)
            do {
                let results = try context.fetch(featchRequest)
                for result in results as! [NSManagedObject] {
                    context.delete(result)
                }
                try context.save()
            } catch {
                print("Failed deleting")
            }
            loadAdvertising()
        }
    func savePromo(key: String, value: Double){
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Promocode", in: context)
        let newItem = NSManagedObject(entity: entity!, insertInto: context)
            
            newItem.setValue(key, forKey: "key")
            newItem.setValue(value, forKey: "value")
            
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
    }
    func loadPromo(){
        
        promocodesDictionary = [String: Double]()
        promoArray = [String]()
        
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let featchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Promocode")
        do {
               let results = try context.fetch(featchRequest)
               for result in results as! [NSManagedObject] {
                   let key1 = result.value(forKey: "key") as! String
                   let value1 = result.value(forKey: "value") as! Double
                   promoArray.append(key1)
                   promocodesDictionary[key1] = value1
               }
           } catch {
               print("Failed loading")
           }
    }
    func deletePromo(key: String){
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let featchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Promocode")
            featchRequest.predicate = NSPredicate(format: "key = %@", key)
            do {
                let results = try context.fetch(featchRequest)
                for result in results as! [NSManagedObject] {
                    context.delete(result)
                }
                try context.save()
            } catch {
                print("Failed deleting")
            }
            loadPromo()
        }
}
