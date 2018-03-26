//
//  Restaurants.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation

protocol RestaurantsInterface {
    var domainModel: ModelState<[RestaurantSearch.RestaurantDomainItem]>? { get }
    
    func fetchRestaurants(with query: String?)
}

final class Restaurants {

    private(set) var domainModel: ModelState<[RestaurantSearch.RestaurantDomainItem]>?
        
    private var networking: NetworkingInterface
    private var apiDetails: APIDetails
    
    init(networking: NetworkingInterface, apiDetails: APIDetails) {
        self.networking = networking
        self.apiDetails = apiDetails
    }
        
    func fetchRestaurants() {
        do {
            let url = try apiDetails.urlWithQuery()
            networking.cancelFetch() // mark an inflight fetch as cancelled before starting a new fetch
            networking.fetchData(for: url)
            
        } catch {
            domainModel = .failure(error)
        }
    }
}

extension Restaurants {
    
    func successfulFetch(data: Data?) throws -> [RestaurantSearch.RestaurantDomainItem] {
        if let data = data {
            let response = try JSONDecoder().decode(RestaurantSearch.self, from: data)
            return response.restaurants.flatMap({ $0.values })
        } else {
            return [RestaurantSearch.RestaurantDomainItem]()
        }
    }
    
    func dataFetchComplete(result: ModelState<[RestaurantSearch.RestaurantDomainItem]>) {
        self.domainModel = result
    }
}
