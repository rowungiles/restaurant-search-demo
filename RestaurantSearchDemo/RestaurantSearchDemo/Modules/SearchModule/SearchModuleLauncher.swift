//
//  SearchModuleLauncher.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import UIKit

struct SearchModuleLauncher {
    
    static func configureViewController(_ viewController: UIViewController?) {
        guard let viewController = viewController as? ResultsViewController else {
            return
        }
        
        let api = ZomatoAPI()
        
        let networking = Networking<Restaurants>()
        let model = Restaurants(networking: networking, apiDetails: api)
        networking.setDelegate(model)
        
        viewController.configure(restaurants: model)
    }
}
