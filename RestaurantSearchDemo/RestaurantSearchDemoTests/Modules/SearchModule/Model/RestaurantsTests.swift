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
    
    private var mockedAPIDetails: MockAPIDetails!
    private var mockedNetworking: MockNetworking!
    private var restaurants: Restaurants!
    
    override func setUp() {
        super.setUp()
        
        mockedAPIDetails = MockAPIDetails(state: .success)
        mockedNetworking = MockNetworking()
        restaurants = Restaurants(networking: mockedNetworking, apiDetails: mockedAPIDetails)
    }

    func test_WhenFetchRestaurantsCalled_ThenCallIsMadeToDataProviderToCancel() {
        restaurants.fetchRestaurants()
        
        XCTAssertTrue(mockedNetworking.cancelFetchCalled == 1)
    }
    
    func test_WhenFetchRestaurantsCalled_ThenCallIsMadeToDataProviderZomatoAPIURL() {
        let apiDetails = ZomatoAPI()
        
        let expectedURL = try! apiDetails.urlWithQuery()
        
        restaurants = Restaurants(networking: mockedNetworking, apiDetails: apiDetails)
        restaurants.fetchRestaurants()
        
        XCTAssertTrue(mockedNetworking.fetchDataCalled == 1)
        XCTAssertTrue(mockedNetworking.capturedURL?.absoluteString == expectedURL.absoluteString)
    }
    
    func test_GivenInvalidURL_WhenFetchRestaurantsCalled_ThenModelIsMarkedAsFailure() {
        mockedAPIDetails = MockAPIDetails(state: .failure)
        mockedNetworking = MockNetworking()
        restaurants = Restaurants(networking: mockedNetworking, apiDetails: mockedAPIDetails)
        
        restaurants.fetchRestaurants()
        
        if case .failure(let _)? = restaurants.domainModel {
            XCTAssertTrue(true)
        } else {
            XCTFail()
        }
    }
}
