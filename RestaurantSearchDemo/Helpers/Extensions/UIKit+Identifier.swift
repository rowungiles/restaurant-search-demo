//
//  UIKit+Identifier.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import UIKit

protocol Identifier: class {}
extension Identifier {
    static var identifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: Identifier {}
