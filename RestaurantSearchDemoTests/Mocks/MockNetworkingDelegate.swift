//
//  MockNetworkingDelegate.swift
//  RestaurantSearchDemoTests
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import XCTest
@testable import RestaurantSearchDemo

final class MockNetworkingDelegate: FetchDelegate {
    
    var expectation: XCTestExpectation?
    
    var successfulFetchCalled = 0
    var capturedSuccessfulFetchData: Data?
    
    var dataFetchCompleteCalled = 0
    var capturedModelState: ModelState<[RestaurantSearch.RestaurantDomainItem]>?
    
    func successfulFetch(data: Data?) throws -> [RestaurantSearch.RestaurantDomainItem] {
        successfulFetchCalled += 1
        capturedSuccessfulFetchData = data
        
        if let data = data {
            let response = try JSONDecoder().decode(RestaurantSearch.self, from: data)
            return response.restaurants.flatMap({ $0.values })
        } else {
            return []
        }
    }
    
    func dataFetchComplete(result: ModelState<[RestaurantSearch.RestaurantDomainItem]>) {
        dataFetchCompleteCalled += 1
        capturedModelState = result
        
        expectation?.fulfill()
    }
}
