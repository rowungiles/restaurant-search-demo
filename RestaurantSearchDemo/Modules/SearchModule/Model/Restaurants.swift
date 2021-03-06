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
    
    func registerChangeObserver(_ object: NSObject, onChange: Selector)
}

final class Restaurants: RestaurantsInterface, ObserverNotifier {

    // ObserverNotifier implementation detail
    static let ChangeNotificationName = ObserverNotificationNameConstants.modelChangedNotificationName(for: Restaurants.self)
    private(set) var domainModel: ModelState<[RestaurantSearch.RestaurantDomainItem]>? {
        didSet {
            notifyObserverOfChange()
        }
    }
    
    // Networking implementation detail
    private var networking: NetworkingInterface
    private var apiDetails: APIDetails
    
    init(networking: NetworkingInterface, apiDetails: APIDetails) {
        self.networking = networking
        self.apiDetails = apiDetails
    }
}

extension Restaurants {
    
    func fetchRestaurants(with query: String?) {
        do {
            let url = try apiDetails.urlWithQuery(query)
            networking.cancelFetch() // mark an inflight fetch as cancelled before starting a new fetch
            networking.fetchData(for: url, additionalHeaders: apiDetails.additionalHeaders())
            
        } catch {
            domainModel = .failure(error)
        }
    }
}

extension Restaurants: FetchDelegate {
    
    func successfulFetch(data: Data?) throws -> [RestaurantSearch.RestaurantDomainItem] {
        if let data = data {
            let response = try JSONDecoder().decode(RestaurantSearch.self, from: data)
            return response.restaurants.flatMap({ $0.values })
        }
        
        return [RestaurantSearch.RestaurantDomainItem]()
    }
    
    func dataFetchComplete(result: ModelState<[RestaurantSearch.RestaurantDomainItem]>) {
        self.domainModel = result
    }
}
