//
//  MockURLSessionDataTask.swift
//  RestaurantSearchDemoTests
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation
@testable import RestaurantSearchDemo

final class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var state: URLSessionTask.State = .suspended
    
    func cancel() {}
    func resume() {}
}
