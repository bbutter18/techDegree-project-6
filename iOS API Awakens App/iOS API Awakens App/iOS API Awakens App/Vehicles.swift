//
//  Vehicles.swift
//  iOS API Awakens App
//
//  Created by Woodchuck on 10/17/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation


struct Vehicles: Codable, SWTransportable {

    var name: String?
    var make: String?
    var cost: String?
    var length: String?
    var classType: String?
    var crew: String?
}

extension Vehicles {
    init?(json: [String: Any]) {
        
        struct Key {
            static let name = "name"
            static let make = "manufacturer"
            static let cost = "cost_in_credits"
            static let length = "length"
            static let classType = "vehicle_class"
            static let crew = "crew"
        }
        
        guard let nameValue = json[Key.name] as? String,
            let makeValue = json[Key.make] as? String,
            let costValue = json[Key.cost] as? String,
            let lengthValue = json[Key.length] as? String,
            let vehicleClassValue = json[Key.classType] as? String,
            let crewValue = json[Key.crew] as? String else {
                return nil
        }
        
        self.name = nameValue
        self.make = makeValue
        self.cost = costValue
        self.length = lengthValue
        self.classType = vehicleClassValue
        self.crew = crewValue
        
    }
}


extension Vehicles: TransportSortable {
    var sortLengthValue: Double {
        return Double(self.length!) ?? 0.0
    }
}




