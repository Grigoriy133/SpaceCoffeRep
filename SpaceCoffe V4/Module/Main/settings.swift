//
//  Settings.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 12.05.2023.
//

import Foundation


enum languageEnum: String{
    case russian = "russian"
    case english = "english"
}

class settings{
    static let shared = settings()
    var language = languageEnum.russian
    var currentUserName = ""
    var isUserOwner = false
    
    let keyLanguage = "language"
    let keyCurrentUserName = "UserName"
    let keyIsUserOwner = "UserType"
    
    init(language: languageEnum = languageEnum.russian) {
        self.language = language
    }
    
    func loadSettings(){
        let languageString = UserDefaults.standard.string(forKey: keyLanguage) ?? "russian"
        if let language1 = languageEnum(rawValue: languageString) {
            settings.shared.language = language1
        } else {
            print("Error selected language is not avaliable")
        }
        currentUserName = UserDefaults.standard.string(forKey: keyCurrentUserName) ?? ""
        isUserOwner = UserDefaults.standard.bool(forKey: keyIsUserOwner)
    }
    func settupCurrentUser(nameUser: String, typeUser: Bool){
        UserDefaults.standard.set(nameUser, forKey: keyCurrentUserName)
        UserDefaults.standard.set(typeUser, forKey: keyIsUserOwner)
    }
}
