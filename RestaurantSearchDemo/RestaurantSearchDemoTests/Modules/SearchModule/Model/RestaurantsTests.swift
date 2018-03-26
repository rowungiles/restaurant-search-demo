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
        restaurants.fetchRestaurants(with: "")
        
        XCTAssertTrue(mockedNetworking.cancelFetchCalled == 1)
    }
    
    func test_WhenFetchRestaurantsCalled_ThenCallIsMadeToDataProviderWithZomatoAPIURL() {
        let apiDetails = ZomatoAPI()
        
        do {
            let expectedURL = try apiDetails.urlWithQuery("")
            restaurants = Restaurants(networking: mockedNetworking, apiDetails: apiDetails)
            restaurants.fetchRestaurants(with: "")
            
            XCTAssertTrue(mockedNetworking.fetchDataCalled == 1)
            XCTAssertTrue(mockedNetworking.capturedURL?.absoluteString == expectedURL.absoluteString)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_WhenFetchRestaurantsCalled_ThenCallIsMadeToDataProviderWithZomatoAPIAdditionalHeaders() {
        let apiDetails = ZomatoAPI()
        
        let expectedHeaders = apiDetails.additionalHeaders()
        restaurants = Restaurants(networking: mockedNetworking, apiDetails: apiDetails)
        restaurants.fetchRestaurants(with: "")
        guard let expectedValues = expectedHeaders?.values.flatMap({ $0 as? String }),
            let capturedValues = mockedNetworking.capturedAdditionalHeaders?.values.flatMap({ $0 as? String }) else {
                return XCTFail("expected additional header values")
        }
        
        XCTAssertTrue(mockedNetworking.fetchDataCalled == 1)
        XCTAssertTrue(expectedValues == capturedValues)
        XCTAssertTrue(mockedNetworking.capturedAdditionalHeaders?.keys == expectedHeaders?.keys)
    }
    
    func test_GivenInvalidURL_WhenFetchRestaurantsCalled_ThenModelIsMarkedAsFailure() {
        mockedAPIDetails = MockAPIDetails(state: .failure)
        mockedNetworking = MockNetworking()
        restaurants = Restaurants(networking: mockedNetworking, apiDetails: mockedAPIDetails)
        
        restaurants.fetchRestaurants(with: "")
        
        if case .failure(_)? = restaurants.domainModel {
            XCTAssertTrue(true)
        } else {
            XCTFail()
        }
    }
    
    func test_GivenSuccess_WhenSuccessfulFetchCalled_ThenReturnsRestaurantItems() {
        do {
            let path = Bundle(for: RestaurantsTests.self).path(forResource: "mock-api-response", ofType: "json")!
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let result = try restaurants.successfulFetch(data: data)
        
            XCTAssertTrue(result.count == 1)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_GivenSuccessButNilData_WhenSuccessfulFetchCalled_ThenReturnsEmptyRestaurantItems() {
        do {
            let result = try restaurants.successfulFetch(data: nil)
            
            XCTAssertTrue(result.count == 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_WhenDataFetchCompleteCalled_ThenModelIsMarkedAsSuccess() {
        restaurants.dataFetchComplete(result: .success([]))
        
        if case .success(_)? = restaurants.domainModel {
            XCTAssertTrue(true)
        } else {
            XCTFail()
        }
    }
}
