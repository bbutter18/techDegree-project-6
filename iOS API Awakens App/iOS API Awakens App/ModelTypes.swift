//
//  ModelTypes.swift
//  iOS API Awakens App
//
//  Created by Woodchuck on 10/17/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation
import UIKit



enum MeasurementType {
    case English
    case Metric
}

enum CostType {
    case USD
    case Credits
}

protocol SWPersonable {

    var name: String? { get set }
    var born: String? { get set }
    var home: String? { get set }
    var height: String? { get set }
    var eyes: String? { get set }
    var hair: String? { get set }
    
}

protocol SWTransportable {
    var name: String? { get set }
    var make: String? { get set }
    var cost: String? { get set }
    var length: Double? { get set }
    var classType: String? { get set }
    var crew: String? { get set }
}


protocol Sortable {
    associatedtype SortableType: Comparable
    var sortHeightValue: SortableType { get }
}



