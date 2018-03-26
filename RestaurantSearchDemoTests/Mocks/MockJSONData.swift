//
//  MockJSONData.swift
//  RestaurantSearchDemoTests
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation

struct MockJSONData {
    
    static func correctResponseData() -> Data {
        let path = Bundle(for: RestaurantsTests.self).path(forResource: "mock-api-response", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)

        return data
    }
    
    static func incorrectResponseData() -> Data {
        let path = Bundle(for: RestaurantsTests.self).path(forResource: "mock-api-incorrect-response", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        
        return data
    }
}
