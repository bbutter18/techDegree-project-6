//
//  IdentificationDetails.swift
//  iOS API Awakens App
//
//  Created by Woodchuck on 10/17/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation


struct endpointDetails {
    let idType: endpointID
}

//this is used as an endpoint for the base URL www.swapi.co/api/idType/
extension endpointDetails: CustomStringConvertible {
    var description: String {
        return "\(idType)/"
    }
}



