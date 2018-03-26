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
        let result: ModelState<Object>
        
        do {
            result = try .success(successfulFetch(data: data))
        } catch {
            result = .failure(error)
        }
        
        return result
    }
    
    func failureResponse(error: Error?) -> ModelState<Object> {
        let result: ModelState<Object>
        
        if let error = error {
            result = .failure(error)
        } else {
            result = .failure(FetchError.unknownError)
        }
        
        return result
    }
}
