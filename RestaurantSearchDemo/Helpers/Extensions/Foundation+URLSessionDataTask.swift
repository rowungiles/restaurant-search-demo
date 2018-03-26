//
//  Foundation+URLSessionDataTask.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation

protocol URLSessionDataTaskProtocol: class {
    var state: URLSessionTask.State { get }
    
    func resume()
    func cancel()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
