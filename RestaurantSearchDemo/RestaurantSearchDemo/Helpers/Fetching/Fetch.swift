//
//  Fetch.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation
protocol Fetch {
    associatedtype Object
    
    func successfulFetch(data: Data?) throws -> Object
}

extension Fetch {
    
    func successResponse(data: Data?) -> ModelState<Object> {
        do {
            return try .success(successfulFetch(data: data))
        } catch {
            return .failure(error)
        }
    }
    
    func failureResponse(error: Error?) -> ModelState<Object> {
        if let error = error {
            return .failure(error)
        } else {
            return .failure(FetchError.unknownError)
        }
    }
}
