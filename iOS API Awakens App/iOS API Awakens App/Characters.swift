//
//  Characters.swift
//  iOS API Awakens App
//
//  Created by Woodchuck on 10/17/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation


struct Character: Codable, SWPersonable {
    var name: String?
    var born: String?
    var home: String?
    var height: String?
    var eyes: String?
    var hair: String?
    
    
}


extension Character {
    init?(json: [String: Any]) {
    
        struct Key {
            static let name = "name"
            static let born = "birth_year"
            static let home = "homeworld"
            static let height = "height"
            static let eyes = "eye_color"
            static let hair = "hair_color"
        }
        //this is type casting the json already, since the json is in a dictionary of strings to any objects
//        guard let nameValue = json[Key.name] as? String,
//            let bornValue = json[Key.born] as? String,
//            let homeValue = json[Key.home] as? String,
//            let heightValue = json[Key.height] as? String,
//            let eyesValue = json[Key.eyes] as? String,
//            let hairValue = json[Key.hair] as? String else {
//                return nil
//        }
        
        self.name = json[Key.name] as? String
        self.born = json[Key.born] as? String
        self.home = json[Key.home] as? String
        self.eyes = json[Key.eyes] as? String
        self.hair = json[Key.hair] as? String
        self.height = json[Key.height] as? String
        
//        guard let heightValueUnwrapped = height else {
//            return nil
//        }
        
//        self.height = Double(heightValueUnwrapped)
        
    }
}

extension Character: Sortable {
    var sortHeightValue: Double {
        return Double(self.height!) ?? 0.0
    }
}








