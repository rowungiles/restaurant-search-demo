//
//  Networking.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation

protocol NetworkingInterface {
    func fetchData(for url: URL, additionalHeaders: [AnyHashable: Any]?)
    func cancelFetch()
}
