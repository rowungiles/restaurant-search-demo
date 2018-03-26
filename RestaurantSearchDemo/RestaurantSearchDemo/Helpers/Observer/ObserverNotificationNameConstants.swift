//
//  ObserverNotificationNameConstants.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation

struct ObserverNotificationNameConstants {
    private static let modelChanged = ".ModelChangedNotificationName"
    
    static func modelChangedNotificationName<T>(for classType: T.Type) -> Notification.Name {
        let string = String(describing: classType) + ObserverNotificationNameConstants.modelChanged
        return Notification.Name(rawValue: string)
    }
}
