//
//  ZomatoAPI.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation

struct ZomatoAPI: Codable, PlistDecoder {
    
    fileprivate struct APIConstants {
        static let authorisation = "user-key"
    }
    
    private let baseURL: String
    private let apiPath: String
    private let apiVersionPath: String
    private let searchPath: String
    
    private let londonCityTypeDemoSearchQuery: String // hardcoded to a London city id & city type for demo purposes
    
    init() {
        self = ZomatoAPI.plistData()
    }
}

extension ZomatoAPI: APIDetails {
    
    func urlWithQuery() throws -> URL {
        let baseComponentsURLString = baseURL + apiPath + apiVersionPath + searchPath + londonCityTypeDemoSearchQuery
        let urlString = baseComponentsURLString
        
        guard let url = URL(string: urlString) else {
            throw APIDetailsErrors.invalidURL
        }
        
        return url
    }
}
