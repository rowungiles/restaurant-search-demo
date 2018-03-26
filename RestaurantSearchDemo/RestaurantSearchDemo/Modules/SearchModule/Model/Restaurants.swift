//
//  Restaurants.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation

final class Restaurants {
    
    private var networking: NetworkingInterface
    
    init(networking: NetworkingInterface) {
        self.networking = networking
    }
        
    func fetchRestaurants() {
        let url = URL(string: "https://zomato.com")!
        networking.fetchData(for: url)
    }
}
