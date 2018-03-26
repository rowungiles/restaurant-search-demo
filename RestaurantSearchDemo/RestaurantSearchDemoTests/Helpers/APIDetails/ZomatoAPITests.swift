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
    
    func test_WhenURLWithQueryCalled_ThenReturnsURL() {
        let zomato = ZomatoAPI()

        XCTAssertNoThrow(try zomato.urlWithQuery())
        
        let url = try? zomato.urlWithQuery()
        XCTAssertNotNil(url)
    }
    
    func test_WhenInitZomatoAPI_ThenInitsWithDataFromPlist() {
        let zomato = ZomatoAPI()
        
        let url = try! zomato.urlWithQuery()
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        XCTAssertTrue(components?.scheme == "https")
        XCTAssertTrue(components?.host == "developers.zomato.com")
        XCTAssertTrue(components?.path == "/api/v2.1/search")
        XCTAssertTrue(components?.query == "entity_id=61&entity_type=city&q=")
    }
}
