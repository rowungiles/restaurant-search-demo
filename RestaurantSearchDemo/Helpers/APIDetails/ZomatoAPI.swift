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
    
    private let londonCityTypeDemoSearchQuery: String // hardcoded as type city, and city is London.
    
    init() {
        self = ZomatoAPI.plistData()
    }
}

extension ZomatoAPI: APIDetails {
    
    func urlWithQuery(_ query: String?) throws -> URL {
        guard let query = query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw APIDetailsErrors.missingQuery
        }
        
        let baseComponentsURLString = baseURL + apiPath + apiVersionPath + searchPath + londonCityTypeDemoSearchQuery
        let urlString = baseComponentsURLString + query
        
        guard let url = URL(string: urlString) else {
            throw APIDetailsErrors.invalidURL
        }
        
        return url
    }
    
    func additionalHeaders() -> [AnyHashable: Any]? {
        let apiTokens = APITokens()
        
        return [
            StandardAPIHeaders.accept: StandardAPIHeaders.applicationJson,
            APIConstants.authorisation: apiTokens.zomato
        ]
    }
}
