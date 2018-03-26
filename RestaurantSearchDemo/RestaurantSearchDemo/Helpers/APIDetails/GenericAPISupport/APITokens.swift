//
//  APITokens.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation

struct APITokens: Codable, PlistDecoder {
    
    fileprivate struct APIKeys {
        static let zomato = String(describing: ZomatoAPI.self)
    }
    
    let zomato: String
    
    init() {
        self = APITokens.plistData()
    }
}
