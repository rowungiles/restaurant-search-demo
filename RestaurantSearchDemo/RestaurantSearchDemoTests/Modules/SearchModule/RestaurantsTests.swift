//
//  RestaurantsTests.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import XCTest
@testable import RestaurantSearchDemo

final class RestaurantsTests: XCTestCase {
    
    private var mockedNetworking: MockNetworking!
    private var restaurants: Restaurants!
    
    override func setUp() {
        super.setUp()
        
        mockedNetworking = MockNetworking()
        restaurants = Restaurants(networking: mockedNetworking)
    }
    
    func test_WhenFetchRestaurantsCalled_ThenCallIsMadeToDataProviderWithURL() {
        let url = URL(string: "https://zomato.com")!
        
        restaurants.fetchRestaurants()
        
        XCTAssertTrue(mockedNetworking.fetchDataCalled == 1)
        XCTAssertTrue(mockedNetworking.capturedURL == url)
    }
}
