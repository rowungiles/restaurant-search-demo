//
//  ResultTableViewCell.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import UIKit

final class ResultTableViewCell: UITableViewCell {
    
    func configure(using viewModel: RestaurantViewModelItem) {
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.description
    }
}
