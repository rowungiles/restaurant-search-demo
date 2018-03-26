//
//  PlistDecoder.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation

fileprivate struct DeviceConstants {
    static let plistExtension = "plist"
}

protocol PlistDecoder: Codable {}

extension PlistDecoder {
    
    static func plistData() -> Self? {
        guard let path = Bundle.main.path(forResource: String(describing: Self.self), ofType: DeviceConstants.plistExtension), let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }
        
        let decoder = PropertyListDecoder()
        
        guard let provider = try? decoder.decode(Self.self, from: data) else {
            return nil
        }
        
        return provider
    }
}
