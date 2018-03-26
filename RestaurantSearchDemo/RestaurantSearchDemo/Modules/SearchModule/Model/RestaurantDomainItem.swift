//
//  RestaurantDomainItem.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation

import Foundation

struct RestaurantSearch: Codable {
    
    struct RestaurantDomainItem: Codable {
        let name: String
        let cuisines: String
        
        // included these unused properties to show use of a ViewModel for a subset of the DomainItem data
        let thumb: String // showing images adds additional complication - skip for now
        let url: String // could use an SFSafariViewController to show this
        
        // lots of additional data for UI opportunities available e.g. address pins on a map
    }
    
    let restaurants: [[String: RestaurantDomainItem]]
}
