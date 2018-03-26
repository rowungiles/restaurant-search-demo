//
//  FetchDelegate.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation

protocol FetchDelegate: class {
    associatedtype Object
    
    func successfulFetch(data: Data?) throws -> Object
    func dataFetchComplete(result: ModelState<Object>)
}
