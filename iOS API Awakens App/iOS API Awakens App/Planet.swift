//
//  Planet.swift
//  iOS API Awakens App
//
//  Created by Dennis Parussini on 11.11.18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation

struct Planet {
    let name: String?
    
    init(json: [String: Any]) {
        
        self.name = json["name"] as? String
    }
}
