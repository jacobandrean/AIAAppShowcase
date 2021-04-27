//
//  HomeViewController.swift
//  AIAAppShowcase
//
//  Created by Jacob Andrean on 24/04/21.
//

import UIKit

class StocksViewController: UIViewController {

    private let searchController = UISearchController(searchResultsController: nil)
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, _) -> NSCollectionLayoutSection? in
        return StocksViewController.createSectionLayout(section: sectionIndex)
    }))
    
    var stockDates: [String] = []
    var stockCharts: [String: TimeSeries] = [:]
    
    var interval: String = "1min"
    var outputSize: String = "compact"
    var apiKey: String = ""
    var symbol: String = "IBM"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureSearchController()
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func configureSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(SortCollectionViewCell.self,
                                forCellWithReuseIdentifier: SortCollectionViewCell.identifier)
        collectionView.register(StockCollectionViewCell.self,
                                forCellWithReuseIdentifier: StockCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
    }
    
    private func fetchData() {
        guard let intervalFromUserDefaults = UserDefaults.standard.string(forKey: "Interval"),
              let outputSizeFromUserDefaults = UserDefaults.standard.string(forKey: "OutputSize"),
              let apiKeyFromUserDefaults = UserDefaults.standard.string(forKey: "APIKey") else {
            return
        }
        stockDates = []
        stockCharts = [:]
        collectionView.reloadData()
        interval = intervalFromUserDefaults
        outputSize = outputSizeFromUserDefaults
        apiKey = apiKeyFromUserDefaults
        let group = DispatchGroup()
        group.enter()
        let alert = UIAlertController(title: "Fetching Stock...", message: "", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        switch interval {
        case "1min":
            APICaller.shared.getOneMinIntraday(function: .TIME_SERIES_INTRADAY, symbol: symbol, outputSize: outputSize, apiKey: apiKey) { [weak self] (result) in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let stock):
                    self?.stockDates.append(contentsOf: stock.timeSeries.keys)
                    self?.stockCharts = stock.timeSeries
                case .failure(let error):
                    print(error)
                }
            }
        case "5min":
            APICaller.shared.getFiveMinIntraday(function: .TIME_SERIES_INTRADAY, symbol: symbol, outputSize: outputSize, apiKey: apiKey) { [weak self] (result) in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let stock):
                    self?.stockDates.append(contentsOf: stock.timeSeries.keys)
                    self?.stockCharts = stock.timeSeries
                case .failure(let error):
                    print(error)
                }
            }
        case "15min":
            APICaller.shared.getFifteenMinIntraday(function: .TIME_SERIES_INTRADAY, symbol: symbol, outputSize: outputSize, apiKey: apiKey) { [weak self] (result) in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let stock):
                    self?.stockDates.append(contentsOf: stock.timeSeries.keys)
                    self?.stockCharts = stock.timeSeries
                case .failure(let error):
                    print(error)
                }
            }
        case "30min":
            APICaller.shared.getThirtyMinIntraday(function: .TIME_SERIES_INTRADAY, symbol: symbol, outputSize: outputSize, apiKey: apiKey) { [weak self] (result) in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let stock):
                    self?.stockDates.append(contentsOf: stock.timeSeries.keys)
                    self?.stockCharts = stock.timeSeries
                case .failure(let error):
                    print(error)
                }
            }
        case "60min":
            APICaller.shared.getSixtyMinIntraday(function: .TIME_SERIES_INTRADAY, symbol: symbol, outputSize: outputSize, apiKey: apiKey) { [weak self] (result) in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let stock):
                    self?.stockDates.append(contentsOf: stock.timeSeries.keys)
                    self?.stockCharts = stock.timeSeries
                case .failure(let error):
                    print(error)
                }
            }
        default:
            group.leave()
            break
        }
        group.notify(queue: .main) {
            self.dismiss(animated: true, completion: nil)
            if self.stockDates.count == 0 {
                self.title = "Stock"
                let alert = UIAlertController(title: "Failed to Fetch Stock", message: "", preferredStyle: .alert)
                self.present(alert, animated: true) {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] (_) in
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            } else {
                self.collectionView.reloadData()
                self.title = self.symbol
            }
        }
    }

}

extension StocksViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchSymbol = searchBar.text else {
            return
        }
        symbol = searchSymbol.uppercased()
        searchController.isActive = false
        fetchData()
    }
}

extension StocksViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return stockDates.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortCollectionViewCell.identifier, for: indexPath) as? SortCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StockCollectionViewCell.identifier, for: indexPath) as? StockCollectionViewCell else {
                return UICollectionViewCell()
            }
            let dates = stockDates[indexPath.row]
            let charts = stockCharts[dates]
            cell.configureCell(date: dates, open: charts?.open, high: charts?.high, low: charts?.low)
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        
        switch section {
        case 0:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .estimated(1275),
                    heightDimension: .absolute(40)
                ),
                subitem: item,
                count: 1
            )
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 0)
            return section
        case 1:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalWidth(1.0)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(140)
                ),
                subitem: item,
                count: 1
            )
            let section = NSCollectionLayoutSection(group: group)
            return section
        default:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(80)
                ),
                subitem: item,
                count: 1
            )
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
    
}

extension StocksViewController: SortCollectionViewCellDelegate {
    func sortStock(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            // highest open
            let sortedCharts = stockCharts.sorted(by: {$0.value.open > $1.value.open})
            stockDates = []
            stockDates.append(contentsOf: sortedCharts.compactMap({$0.key}))
            collectionView.reloadData()
        case 1:
            // lowest open
            let sortedCharts = stockCharts.sorted(by: {$0.value.open < $1.value.open})
            stockDates = []
            stockDates.append(contentsOf: sortedCharts.compactMap({$0.key}))
            collectionView.reloadData()
        case 2:
            // highest high
            let sortedCharts = stockCharts.sorted(by: {$0.value.high > $1.value.high})
            stockDates = []
            stockDates.append(contentsOf: sortedCharts.compactMap({$0.key}))
            collectionView.reloadData()
        case 3:
            // lowest high
            let sortedCharts = stockCharts.sorted(by: {$0.value.high < $1.value.high})
            stockDates = []
            stockDates.append(contentsOf: sortedCharts.compactMap({$0.key}))
            collectionView.reloadData()
        case 4:
            // highest low
            let sortedCharts = stockCharts.sorted(by: {$0.value.low > $1.value.low})
            stockDates = []
            stockDates.append(contentsOf: sortedCharts.compactMap({$0.key}))
            collectionView.reloadData()
        case 5:
            // lowest low
            let sortedCharts = stockCharts.sorted(by: {$0.value.low < $1.value.low})
            stockDates = []
            stockDates.append(contentsOf: sortedCharts.compactMap({$0.key}))
            collectionView.reloadData()
        case 6:
            // newest
            stockDates = stockDates.sorted(by: {$0 > $1})
            collectionView.reloadData()
        case 7:
            // oldest
            stockDates = stockDates.sorted(by: {$0 < $1})
            collectionView.reloadData()
        default:
            break
        }
    }
    
}
