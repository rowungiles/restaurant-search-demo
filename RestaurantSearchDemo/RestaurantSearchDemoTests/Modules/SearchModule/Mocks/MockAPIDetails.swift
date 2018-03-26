//
//  MockAPIDetails.swift
//  RestaurantSearchDemoTests
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation
@testable import RestaurantSearchDemo

struct MockAPIDetails: APIDetails {
    enum State {
        case success
        case failure
    }
    
    private let state: State
    
    init(state: State) {
        self.state = state
    }
    
    func urlWithQuery(_ query: String?) throws -> URL {
        switch state {
        case .success:
            return URL(string: "https://zomato.com")!
        case .failure:
            throw APIDetailsErrors.invalidURL
        }
    }
    
    func additionalHeaders() -> [AnyHashable : Any]? {
        return nil
    }
}
