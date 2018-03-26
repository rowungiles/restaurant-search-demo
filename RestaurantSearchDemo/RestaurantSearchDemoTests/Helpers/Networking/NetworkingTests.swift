//
//  NetworkingTests.swift
//  RestaurantSearchDemoTests
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import XCTest
@testable import RestaurantSearchDemo

final class NetworkingTests: XCTestCase {
    
    private var mockedNetworkingDelegate: MockNetworkingDelegate!
    private var networking: Networking<MockNetworkingDelegate>!
    
    override func setUp() {
        super.setUp()
        
        mockedNetworkingDelegate = MockNetworkingDelegate()
        networking = Networking()
    }

    func test_WhenSuccessfulFetchCalled_ThenCallsDelegateWithData() {
        networking.setDelegate(mockedNetworkingDelegate)
        
        do {
            _ = try networking.successfulFetch(data: MockJSONData.correctResponseData())
            XCTAssertTrue(mockedNetworkingDelegate.successfulFetchCalled == 1)
            XCTAssertNotNil(mockedNetworkingDelegate.capturedSuccessfulFetchData)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_GivenNoDelegate_WhenSuccessfulFetchCalled_ThenThrows() {
        XCTAssertThrowsError(try networking.successfulFetch(data: MockJSONData.correctResponseData()))
    }
    
    func test_WhenSuccessResponseCalled_ReturnsObject() {
        networking.setDelegate(mockedNetworkingDelegate)
        
        let response: ModelState<[RestaurantSearch.RestaurantDomainItem]> = networking.successResponse(data: MockJSONData.correctResponseData())
        
        if case .success(let objects) = response {
            XCTAssertTrue(objects.first?.url == "https://www.zomato.com/london/camden-food-co-euston?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1")
        } else {
            XCTFail("expected a success")
        }
    }
    
    func test_GivenIncorrectData_WhenSuccessResponseCalled_ReturnsObject() {
        networking.setDelegate(mockedNetworkingDelegate)
        
        let response: ModelState<[RestaurantSearch.RestaurantDomainItem]> = networking.successResponse(data: MockJSONData.incorrectResponseData())
        
        if case .failure(_) = response {
            XCTAssertTrue(true)
        } else {
            XCTFail("expected a failure")
        }
    }
    
    func test_GivenError_WhenFailureResponseCalled_ModelStateWithError() {
        networking.setDelegate(mockedNetworkingDelegate)
        
        let response: ModelState<[RestaurantSearch.RestaurantDomainItem]> = networking.failureResponse(error: FetchError.unknownError)
        
        if case .failure(let error) = response {
            XCTAssertTrue(error is FetchError)
        } else {
            XCTFail("expected a failure")
        }
    }
    
    func test_NoGivenError_WhenFailureResponseCalled_ModelStateWithError() {
        networking.setDelegate(mockedNetworkingDelegate)
        
        let response: ModelState<[RestaurantSearch.RestaurantDomainItem]> = networking.failureResponse(error: nil)
        
        if case .failure(_) = response {
            XCTAssertTrue(true)
        } else {
            XCTFail("expected a failure")
        }
    }

    func test_GivenSuccess_WhenFetchDataCalled_ThenCallsDelegateWithSuccess() {
        mockedNetworkingDelegate.expectation = expectation(description: "waiting for networking to call delegate")
        
        do {
            let apiDetails = MockAPIDetails(state: .success)
            let url = try apiDetails.urlWithQuery("")
            
            let mockedSession = MockURLSession()
            mockedSession.mockedURLResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            mockedSession.mockedData = MockJSONData.correctResponseData()
            
            networking.setDelegate(mockedNetworkingDelegate)
            networking.customSession = mockedSession
            
            networking.fetchData(for: url, additionalHeaders: apiDetails.additionalHeaders())
            
            XCTAssertTrue(mockedNetworkingDelegate.dataFetchCompleteCalled == 1)
            
            if case .success(let objects)? = mockedNetworkingDelegate.capturedModelState {
                XCTAssertTrue(objects.first?.url == "https://www.zomato.com/london/camden-food-co-euston?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1")
            } else {
                XCTFail("expected a success")
            }
            
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: 0.3, handler: nil)
    }
    
    func test_GivenFailure_WhenFetchDataCalled_ThenCallsDelegateWithSuccess() {
        mockedNetworkingDelegate.expectation = expectation(description: "waiting for networking to call delegate")
        
        do {
            let apiDetails = MockAPIDetails(state: .success)
            let url = try apiDetails.urlWithQuery("")
            
            let mockedSession = MockURLSession()
            mockedSession.mockedURLResponse = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)
            mockedSession.mockedError = MockError.testError
                
            networking.setDelegate(mockedNetworkingDelegate)
            networking.customSession = mockedSession
            
            networking.fetchData(for: url, additionalHeaders: apiDetails.additionalHeaders())
            
            XCTAssertTrue(mockedNetworkingDelegate.dataFetchCompleteCalled == 1)
            
            if case .failure(let error)? = mockedNetworkingDelegate.capturedModelState {
                XCTAssertTrue(error is MockError)
            } else {
                XCTFail("expected a failure")
            }
            
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: 0.3, handler: nil)
    }
}
