//
//  RestaurantViewModelItemTests.swift
//  RestaurantSearchDemoTests
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import XCTest
@testable import RestaurantSearchDemo

class RestaurantViewModelItemTests: XCTestCase {
    
    func test_GivenRestaurantDomainItem_WhenInit_ThenPopulatsFields() {
        let expectedTitle = "domainItemName"
        let expectedDescription = "domainItemCuisines"
        
        let domainItem = RestaurantSearch.RestaurantDomainItem(name: expectedTitle, cuisines: expectedDescription, thumb: "", url: "")
        let viewModel = RestaurantViewModelItem(domainItem: domainItem)
        
        XCTAssertTrue(viewModel.title == expectedTitle)
        XCTAssertTrue(viewModel.description == expectedDescription)
    }
}
