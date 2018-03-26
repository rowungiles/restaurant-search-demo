//
//  MockNSURLSession.swift
//  RestaurantSearchDemoTests
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation
@testable import RestaurantSearchDemo

final class MockURLSession: URLSessionProtocol {
    var mockedData: Data?
    var mockedURLResponse: URLResponse?
    var mockedError: Error?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTaskProtocol {
        completionHandler(mockedData, mockedURLResponse, mockedError)
        
        return MockURLSessionDataTask()
    }
    
    func invalidateAndCancel() {}
}
