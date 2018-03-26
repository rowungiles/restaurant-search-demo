//
//  Restaurants.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation

protocol RestaurantsInterface {
    var domainModel: ModelState<[Any]>? { get }
    
    func fetchRestaurants(with query: String?)
    func cancelFetch()
}

final class Restaurants {

    private(set) var domainModel: ModelState<[Any]>?
        
    private var networking: NetworkingInterface
    private var apiDetails: APIDetails
    
    init(networking: NetworkingInterface, apiDetails: APIDetails) {
        self.networking = networking
        self.apiDetails = apiDetails
    }
        
    func fetchRestaurants() {
        do {
            let url = try apiDetails.urlWithQuery()
            networking.cancelFetch()
            networking.fetchData(for: url)
            
        } catch {
            domainModel = .failure(error)
        }
    }
}
