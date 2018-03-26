//
//  ObserverNotifier.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation

protocol ObserverNotifier {
    static var ChangeNotificationName: Notification.Name { get }
}

extension ObserverNotifier {
    
    func registerChangeObserver(_ object: NSObject, onChange: Selector) {
        NotificationCenter.default.addObserver(object, selector: onChange, name: Self.ChangeNotificationName, object: self)
    }
    
    func notifyObserverOfChange() {
        NotificationCenter.default.post(name: Self.ChangeNotificationName, object: self)
    }
}
