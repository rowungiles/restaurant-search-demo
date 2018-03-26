//
//  ZomatoAPITests.swift
//  RestaurantSearchDemoTests
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import XCTest
@testable import RestaurantSearchDemo

final class ZomatoAPITests: XCTestCase {
    
    private var zomato: ZomatoAPI!
    
    override func setUp() {
        super.setUp()
        
        zomato = ZomatoAPI()
    }
    
    func test_GivenQueryString_WhenURLWithQueryCalled_ThenReturnsURL() {
        let url = try? zomato.urlWithQuery("")
        XCTAssertNotNil(url)
    }
    
    func test_GivenNoQueryString_WhenURLWithQueryCalled_ThenThrows() {
        XCTAssertThrowsError(try zomato.urlWithQuery(nil))
    }
    
    func test_WhenInitZomatoAPI_ThenInitsWithDataFromPlist() {
        let url = try! zomato.urlWithQuery("test")
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        XCTAssertTrue(components?.scheme == "https")
        XCTAssertTrue(components?.host == "developers.zomato.com")
        XCTAssertTrue(components?.path == "/api/v2.1/search")
        XCTAssertTrue(components?.query == "entity_id=61&entity_type=city&q=test")
    }
    
    func test_WhenAdditionalHeadersCalled_ThenReturnsAdditionalHeaders() {
        let headers = zomato.additionalHeaders()
        
        XCTAssertTrue(headers?[StandardAPIHeaders.accept] as? String == StandardAPIHeaders.applicationJson)
        XCTAssertNotNil(headers?["user-key"] as? String)
    }
}
