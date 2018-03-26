//
//  RestaurantViewModelItem.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation

struct RestaurantViewModelItem {
    let title: String
    let description: String
    
    init(domainModel: RestaurantSearch.RestaurantDomainItem) {
        self.title = domainModel.name
        self.description = domainModel.cuisines
    }
}
