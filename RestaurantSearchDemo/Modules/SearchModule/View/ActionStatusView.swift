//
//  ActionStatusView.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import UIKit

final class ActionStatusView: UIView {
    
    @IBOutlet var status: UILabel!
    
    private struct Constants {
        static let passive = NSLocalizedString("status.passive", comment: "Waiting for user activity")
        static let active = NSLocalizedString("status.active", comment: "Waiting for results of user activity")
        static let success = NSLocalizedString("status.success", comment: "Activity succeeded")
        static let failure = NSLocalizedString("status.failure", comment: "Activity failed")
    }
    
    enum ActionState {
        case active
        case passive
        case success
        case failure
    }
    
    var state: ActionState = .passive {
        didSet {
            switch state {
            case .active:
                self.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
                status.text = Constants.active
            case .passive:
                self.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                status.text = Constants.passive
            case .success:
                self.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                status.text = Constants.success
            case .failure:
                self.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                status.text = Constants.failure
            }
        }
    }
}

