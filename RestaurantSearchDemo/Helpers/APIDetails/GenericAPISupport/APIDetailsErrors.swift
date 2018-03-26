//
//  APIDetailsErrors.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation

enum APIDetailsErrors: Error {
    case missingQuery
    case invalidURL
}
