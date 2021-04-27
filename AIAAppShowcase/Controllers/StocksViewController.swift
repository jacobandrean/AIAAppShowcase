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
    var stockCharts: [TimeSeries] = []
    
    var interval: String = "1min"
    var outputSize: String = "compact"
    var apiKey: String = ""
    var symbol: String = "IBM"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureSearchController()
        configureCollectionView()
        fetchData()
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
        stockCharts = []
        collectionView.reloadData()
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
                        self?.collectionView.reloadData()
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
                        self?.collectionView.reloadData()
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
                        self?.collectionView.reloadData()
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
                        self?.collectionView.reloadData()
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
                        self?.collectionView.reloadData()
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
            cell.configureCell(
                date: stockDates[indexPath.row],
                open: stockCharts[indexPath.row].open,
                high: stockCharts[indexPath.row].high,
                low: stockCharts[indexPath.row].low
            )
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        if indexPath.section == 0 {
            if let cell = collectionView.cellForItem(at: indexPath) as? SortCollectionViewCell {
                cell.selectCell()
            }
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
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        case 6:
            break
        case 7:
            break
        default:
            break
        }
    }
    
}
