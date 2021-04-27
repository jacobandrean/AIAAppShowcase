//
//  ComparisonViewController.swift
//  AIAAppShowcase
//
//  Created by Jacob Andrean on 24/04/21.
//

import UIKit

class ComparisonViewController: UIViewController {
    
    private let firstSymbol: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Symbol"
        textField.autocapitalizationType = .allCharacters
        textField.textAlignment = .center
        textField.layer.cornerRadius = 6
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.layer.borderWidth = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let secondSymbol: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Symbol"
        textField.autocapitalizationType = .allCharacters
        textField.textAlignment = .center
        textField.layer.cornerRadius = 6
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.layer.borderWidth = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let thirdSymbol: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Symbol"
        textField.autocapitalizationType = .allCharacters
        textField.textAlignment = .center
        textField.layer.cornerRadius = 6
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.layer.borderWidth = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let compareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Compare Symbol", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemFill
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(compareSymbol), for: .touchUpInside)
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var stockDates: [String] = []
    var firstCharts: [String: TimeSeriesDaily] = [:]
    var secondCharts: [String: TimeSeriesDaily] = [:]
    var thirdCharts: [String: TimeSeriesDaily] = [:]
    
    var outputSize: String = "compact"
    var apiKey: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        firstSymbol.frame = CGRect(
            x: 20,
            y: view.top+180,
            width: view.width/3 - 25,
            height: 40
        )
        secondSymbol.frame = CGRect(
            x: firstSymbol.right+20,
            y: view.top+180,
            width: view.width/3 - 25,
            height: 40
        )
        thirdSymbol.frame = CGRect(
            x: secondSymbol.right+20,
            y: view.top+180,
            width: view.width/3 - 25,
            height: 40
        )
        compareButton.frame = CGRect(
            x: 20,
            y: thirdSymbol.bottom+20,
            width: view.width - 40,
            height: 40
        )
        tableView.frame = CGRect(
            x: 0,
            y: compareButton.bottom+20,
            width: view.width,
            height: view.height - compareButton.bottom+20
        )
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(firstSymbol)
        view.addSubview(secondSymbol)
        view.addSubview(thirdSymbol)
        view.addSubview(compareButton)
        view.addSubview(tableView)
        tableView.backgroundColor = .systemBackground
        tableView.register(ComparisonTableViewCell.self,
                           forCellReuseIdentifier: ComparisonTableViewCell.identifier)
        tableView.dataSource = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        firstSymbol.resignFirstResponder()
        secondSymbol.resignFirstResponder()
        thirdSymbol.resignFirstResponder()
    }
    
    @objc private func compareSymbol() {
        
        if firstSymbol.text != "" || secondSymbol.text != "" || thirdSymbol.text != "" {
            firstSymbol.resignFirstResponder()
            secondSymbol.resignFirstResponder()
            thirdSymbol.resignFirstResponder()
            fetchData()
        } else {
            let alert = UIAlertController(title: "You need to input at least one symbol", message: "", preferredStyle: .alert)
            self.present(alert, animated: true) {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] (_) in
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    private func fetchData() {
        guard let outputSizeFromUserDefaults = UserDefaults.standard.string(forKey: "OutputSize"),
              let apiKeyFromUserDefaults = UserDefaults.standard.string(forKey: "APIKey") else {
            return
        }
        outputSize = outputSizeFromUserDefaults
        apiKey = apiKeyFromUserDefaults
        stockDates = []
        firstCharts = [:]
        secondCharts = [:]
        thirdCharts = [:]
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        let alert = UIAlertController(title: "Fetching Stock...", message: "", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        if let firstSymbol = firstSymbol.text?.uppercased() {
            print("FIRSTSYMBOL", firstSymbol)
            APICaller.shared.getDailyAdjusted(
                function: .TIME_SERIES_DAILY_ADJUSTED,
                symbol: firstSymbol,
                outputSize: outputSize,
                apiKey: apiKey) { [weak self] (result) in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let stock):
                    self?.stockDates = []
                    self?.stockDates.append(contentsOf: stock.timeSeries.keys)
                    self?.firstCharts = stock.timeSeries
                case .failure(let error):
                    print("fail first",error.localizedDescription)
                }
            }
        }
        if let secondSymbol = secondSymbol.text?.uppercased() {
            print("SECONDSYMBOL", secondSymbol)
            APICaller.shared.getDailyAdjusted(
                function: .TIME_SERIES_DAILY_ADJUSTED,
                symbol: secondSymbol,
                outputSize: outputSize,
                apiKey: apiKey) { [weak self] (result) in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let stock):
                    self?.stockDates = []
                    self?.stockDates.append(contentsOf: stock.timeSeries.keys)
                    self?.secondCharts = stock.timeSeries
                case .failure(let error):
                    print("fail second",error.localizedDescription)
                }
            }
        }
        if let thirdSymbol = thirdSymbol.text?.uppercased() {
            print("THIRDSYMBOL", thirdSymbol)
            APICaller.shared.getDailyAdjusted(
                function: .TIME_SERIES_DAILY_ADJUSTED,
                symbol: thirdSymbol,
                outputSize: outputSize,
                apiKey: apiKey) { [weak self] (result) in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let stock):
                    self?.stockDates = []
                    self?.stockDates.append(contentsOf: stock.timeSeries.keys)
                    self?.thirdCharts = stock.timeSeries
                case .failure(let error):
                    print("fail third",error.localizedDescription)
                }
            }
        }
        group.notify(queue: .main) {
            self.dismiss(animated: true, completion: nil)
            if self.firstCharts.count == 0 && self.firstCharts.count == 0 && self.firstCharts.count == 0 {
                let alert = UIAlertController(title: "Failed to Fetch Stock", message: "", preferredStyle: .alert)
                self.present(alert, animated: true) {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] (_) in
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            } else {
                self.stockDates = self.stockDates.sorted(by: {$0 > $1})
                self.tableView.reloadData()
            }
        }
    }
    
}

extension ComparisonViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stockDates.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return stockDates[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard stockDates.count != 0 else {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dates = stockDates[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ComparisonTableViewCell.identifier, for: indexPath) as? ComparisonTableViewCell else {
            return UITableViewCell()
        }
        let firstChart = firstCharts[dates]
        let secondChart = secondCharts[dates]
        let thirdChart = thirdCharts[dates]
        
        cell.configureCell(
            firstSymbol: firstSymbol.text, firstChart: firstChart,
            secondSymbol: secondSymbol.text, secondChart: secondChart,
            thirdSymbol: thirdSymbol.text, thirdChart: thirdChart
        )
        
        return cell
    }
    
}
