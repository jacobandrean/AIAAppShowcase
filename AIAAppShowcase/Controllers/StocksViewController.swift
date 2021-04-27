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
    
    var stockDates: [String] = []
    var stockCharts: [TimeSeries] = []
    
    var interval: String = "1min"
    var outputSize: String = "compact"
    var apiKey: String = ""
    var symbol: String = "IBM"
    
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
        tableView.register(StockTableViewCell.self,
                           forCellReuseIdentifier: StockTableViewCell.identifier)
        tableView.dataSource = self
    }
    
    private func fetchData() {
        guard let intervalFromUserDefaults = UserDefaults.standard.string(forKey: "Interval"),
              let outputSizeFromUserDefaults = UserDefaults.standard.string(forKey: "OutputSize"),
              let apiKeyFromUserDefaults = UserDefaults.standard.string(forKey: "APIKey") else {
            return
        }
        stockDates = []
        stockCharts = []
        tableView.reloadData()
        interval = intervalFromUserDefaults
        outputSize = outputSizeFromUserDefaults
        apiKey = apiKeyFromUserDefaults
        switch interval {
        case "1min":
            APICaller.shared.getOneMinIntraday(function: .TIME_SERIES_INTRADAY, symbol: symbol, outputSize: outputSize, apiKey: apiKey) { [weak self] (result) in
                switch result {
                case .success(let stock):
                    self?.stockDates.append(contentsOf: stock.timeSeries.keys)
                    self?.stockCharts.append(contentsOf: stock.timeSeries.values)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        case "5min":
            APICaller.shared.getFiveMinIntraday(function: .TIME_SERIES_INTRADAY, symbol: symbol, outputSize: outputSize, apiKey: apiKey) { [weak self] (result) in
                switch result {
                case .success(let stock):
                    self?.stockDates.append(contentsOf: stock.timeSeries.keys)
                    self?.stockCharts.append(contentsOf: stock.timeSeries.values)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        case "15min":
            APICaller.shared.getFifteenMinIntraday(function: .TIME_SERIES_INTRADAY, symbol: symbol, outputSize: outputSize, apiKey: apiKey) { [weak self] (result) in
                switch result {
                case .success(let stock):
                    self?.stockDates.append(contentsOf: stock.timeSeries.keys)
                    self?.stockCharts.append(contentsOf: stock.timeSeries.values)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        case "30min":
            APICaller.shared.getThirtyMinIntraday(function: .TIME_SERIES_INTRADAY, symbol: symbol, outputSize: outputSize, apiKey: apiKey) { [weak self] (result) in
                switch result {
                case .success(let stock):
                    self?.stockDates.append(contentsOf: stock.timeSeries.keys)
                    self?.stockCharts.append(contentsOf: stock.timeSeries.values)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        case "60min":
            APICaller.shared.getSixtyMinIntraday(function: .TIME_SERIES_INTRADAY, symbol: symbol, outputSize: outputSize, apiKey: apiKey) { [weak self] (result) in
                switch result {
                case .success(let stock):
                    self?.stockDates.append(contentsOf: stock.timeSeries.keys)
                    self?.stockCharts.append(contentsOf: stock.timeSeries.values)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        default:
            break
        }
        
    }

}

extension StocksViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchSymbol = searchBar.text else {
            return
        }
        symbol = searchSymbol.uppercased()
        self.title = symbol
        print(symbol)
        searchController.isActive = false
        fetchData()
    }
}

extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if stockDates.count == stockCharts.count {
            return stockDates.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.identifier, for: indexPath) as? StockTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(
            date: stockDates[indexPath.row],
            open: stockCharts[indexPath.row].open,
            high: stockCharts[indexPath.row].high,
            low: stockCharts[indexPath.row].low
        )
        return cell
    }
    
    
}
