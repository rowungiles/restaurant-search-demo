//
//  ResultViewController.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import UIKit

final class ResultsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.tableHeaderView = searchController.searchBar
        }
    }
    
    @IBOutlet var actionStatus: ActionStatusView!
    
    private struct Constants {
        static let searchPauseDelay = 0.9 // pause briefly to ensure a user has actually finished typing
    }
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.delegate = self
        controller.dimsBackgroundDuringPresentation = true
        return controller
    }()
    
    private var restaurants: RestaurantsInterface! {
        didSet {
            restaurants.registerChangeObserver(self, onChange: #selector(modelDidChange))
        }
    }
    
    private var viewModels = [RestaurantViewModelItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configure(restaurants: Restaurants) {
        self.restaurants = restaurants
    }
    
    func configureUI() {
        actionStatus.state = .passive
        definesPresentationContext = true
    }
}

// MARK: UI Updating
extension ResultsViewController {
    
    @objc private func modelDidChange() {
        switch self.restaurants.domainModel {
        case .success(let data)?:
            self.viewModels = data.map({ RestaurantViewModelItem(domainItem: $0) })
            actionStatus.state = .success
            self.tableView.reloadData()
            
        case .failure(_)?:
            actionStatus.state = .failure
            
        default:
            break
        }
    }
}

extension ResultsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as! ResultTableViewCell // programmer error if identifier and type don't match
        cell.configure(using: viewModel)
        return cell
    }
}

extension ResultsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(search(for:)), with: searchText, afterDelay: Constants.searchPauseDelay)
    }
    
    @objc private func search(for text: String?) {
        actionStatus.state = .active
        restaurants.fetchRestaurants(with: text)
    }
}

