//
//  APIDetails.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation

protocol APIDetails {
    func urlWithQuery(_ query: String?) throws -> URL
    func additionalHeaders() -> [AnyHashable: Any]?
}
