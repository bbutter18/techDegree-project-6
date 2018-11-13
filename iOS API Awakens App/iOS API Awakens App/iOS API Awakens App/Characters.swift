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

        guard let nameValue = json[Key.name] as? String,
            let bornValue = json[Key.born] as? String,
            let homeValue = json[Key.home] as? String,
            let heightValue = json[Key.height] as? String,
            let eyesValue = json[Key.eyes] as? String,
            let hairValue = json[Key.hair] as? String else {
                return nil
        }
        
        self.name = nameValue
        self.born = bornValue
        self.home = homeValue
        self.eyes = eyesValue
        self.hair = hairValue
        self.height = heightValue
        
    }
}

extension Character: CharacterSortable {
    var sortHeightValue: Double {
        return Double(self.height!) ?? 0.0
    }
}

struct HomeWorld {
    let name: String?

    init(json: [String: Any]) {
        self.name = json["name"] as? String

    }
}

















