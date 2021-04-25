//
//  HomeViewController.swift
//  AIAAppShowcase
//
//  Created by Jacob Andrean on 24/04/21.
//

import UIKit

class StocksViewController: UIViewController {

    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var stockOneMin: StockOneMin?
    var stockFiveMin: StockFiveMin?
    var stockFifteenMin: StockFifteenMin?
    var stockThirtyMin: StockThirtyMin?
    var stockSixtyMin: StockSixtyMin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureSearchController()
        configureTableView()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchData() {
        APICaller.shared.getOneMinIntraday(function: .TIME_SERIES_INTRADAY, symbol: "IBM") { [weak self] (result) in
            switch result {
            case .success(let stock):
                self?.stockOneMin = stock
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension StocksViewController: UISearchBarDelegate {
    
}

extension StocksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.identifier, for: indexPath) as? StockTableViewCell else {
            return UITableViewCell()
        }
//        cell.configureCell()
        return cell
    }
    
    
}
