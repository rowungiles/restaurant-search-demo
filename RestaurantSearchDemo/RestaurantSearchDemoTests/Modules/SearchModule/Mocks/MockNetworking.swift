//
//  MockNetworking.swift
//  RestaurantSearchDemoTests
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation
@testable import RestaurantSearchDemo

final class MockNetworking: NetworkingInterface {

    var fetchDataCalled = 0
    var capturedURL: URL?
    
    var cancelFetchCalled = 0
    
    func fetchData(for url: URL) {
        fetchDataCalled += 1
        capturedURL = url
    }
    
    func cancelFetch() {
        cancelFetchCalled += 1
    }
}
