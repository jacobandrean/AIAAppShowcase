//
//  APICaller.swift
//  AIAAppShowcase
//
//  Created by Jacob Andrean on 24/04/21.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseEndpoint = "https://www.alphavantage.co/query?"
        static let function = "function="
        static let symbol = "&symbol="
        static let interval = "&interval="
        static let adjusted = "&adjusted="
        static let outputSize = "&outputsize="
        static let datatype = "&datatype="
        static let apiKey = "&apikey="
    }

    enum Function: String {
        case TIME_SERIES_INTRADAY, TIME_SERIES_DAILY_ADJUSTED
    }
    
    enum Interval: String {
        case oneMin = "1min"
        case fiveMin = "5min"
        case fifteenMin = "15min"
        case thirtyMin = "30min"
        case sixtyMin = "60min"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    public func getOneMinIntraday(function: Function, symbol: String, outputSize: String, apiKey: String, completionHandler: @escaping (Result<StockOneMin, Error>) -> Void) {
        let function = Constants.function + function.rawValue
        let symbol = Constants.symbol + symbol
        let interval = Constants.interval + Interval.oneMin.rawValue
        let outputSize = Constants.outputSize + outputSize
        let urlString = Constants.baseEndpoint + function + symbol + interval + outputSize + Constants.apiKey + apiKey
        print(urlString)
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completionHandler(.failure(APIError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(StockOneMin.self, from: data)
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    public func getFiveMinIntraday(function: Function, symbol: String, outputSize: String, apiKey: String, completionHandler: @escaping (Result<StockFiveMin, Error>) -> Void) {
        let function = Constants.function + function.rawValue
        let symbol = Constants.symbol + symbol
        let interval = Constants.interval + Interval.fiveMin.rawValue
        let outputSize = Constants.outputSize + outputSize
        let urlString = Constants.baseEndpoint + function + symbol + interval + outputSize + Constants.apiKey + apiKey
        print(urlString)
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completionHandler(.failure(APIError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(StockFiveMin.self, from: data)
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    public func getFifteenMinIntraday(function: Function, symbol: String, outputSize: String, apiKey: String, completionHandler: @escaping (Result<StockFifteenMin, Error>) -> Void) {
        let function = Constants.function + function.rawValue
        let symbol = Constants.symbol + symbol
        let interval = Constants.interval + Interval.fifteenMin.rawValue
        let outputSize = Constants.outputSize + outputSize
        let urlString = Constants.baseEndpoint + function + symbol + interval + outputSize + Constants.apiKey + apiKey
        print(urlString)
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completionHandler(.failure(APIError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(StockFifteenMin.self, from: data)
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    public func getThirtyMinIntraday(function: Function, symbol: String, outputSize: String, apiKey: String, completionHandler: @escaping (Result<StockThirtyMin, Error>) -> Void) {
        let function = Constants.function + function.rawValue
        let symbol = Constants.symbol + symbol
        let interval = Constants.interval + Interval.thirtyMin.rawValue
        let outputSize = Constants.outputSize + outputSize
        let urlString = Constants.baseEndpoint + function + symbol + interval + outputSize + Constants.apiKey + apiKey
        print(urlString)
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completionHandler(.failure(APIError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(StockThirtyMin.self, from: data)
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    public func getSixtyMinIntraday(function: Function, symbol: String, outputSize: String, apiKey: String, completionHandler: @escaping (Result<StockSixtyMin, Error>) -> Void) {
        let function = Constants.function + function.rawValue
        let symbol = Constants.symbol + symbol
        let interval = Constants.interval + Interval.sixtyMin.rawValue
        let outputSize = Constants.outputSize + outputSize
        let urlString = Constants.baseEndpoint + function + symbol + interval + outputSize + Constants.apiKey + apiKey
        print(urlString)
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completionHandler(.failure(APIError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(StockSixtyMin.self, from: data)
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    public func getDailyAdjusted(function: Function, symbol: String, outputSize: String, apiKey: String, completionHandler: @escaping (Result<StockDaily, Error>) -> Void) {
        let function = Constants.function + function.rawValue
        let symbol = Constants.symbol + symbol
        let outputSize = Constants.outputSize + outputSize
        let urlString = Constants.baseEndpoint + function + symbol + outputSize + Constants.apiKey + apiKey
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completionHandler(.failure(APIError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(StockDaily.self, from: data)
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
}
