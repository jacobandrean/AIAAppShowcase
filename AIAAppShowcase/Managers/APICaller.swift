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
        static let outputsize = "&outputsize="
        static let datatype = "&datatype="
        static let apiKey = "&apikey=KWFWUZ8HYAX1CBAJ"
    }
//    https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=demo
    
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
    
    public func getOneMinIntraday(function: Function, symbol: String, completionHandler: @escaping (Result<StockOneMin, Error>) -> Void) {
        let function = Constants.function + function.rawValue
        let symbol = Constants.symbol + symbol
        let interval = Constants.interval + Interval.oneMin.rawValue
        let urlString = Constants.baseEndpoint + function + symbol + interval + Constants.apiKey
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
    
    public func getFiveMinIntraday(function: Function, symbol: String, completionHandler: @escaping (Result<StockFiveMin, Error>) -> Void) {
        let function = Constants.function + function.rawValue
        let symbol = Constants.symbol + symbol
        let interval = Constants.interval + Interval.fiveMin.rawValue
        let urlString = Constants.baseEndpoint + function + symbol + interval + Constants.apiKey
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
    
    public func getFifteenMinIntraday(function: Function, symbol: String, completionHandler: @escaping (Result<StockFifteenMin, Error>) -> Void) {
        let function = Constants.function + function.rawValue
        let symbol = Constants.symbol + symbol
        let interval = Constants.interval + Interval.fifteenMin.rawValue
        let urlString = Constants.baseEndpoint + function + symbol + interval + Constants.apiKey
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
    
    public func getThirtyMinIntraday(function: Function, symbol: String, completionHandler: @escaping (Result<StockThirtyMin, Error>) -> Void) {
        let function = Constants.function + function.rawValue
        let symbol = Constants.symbol + symbol
        let interval = Constants.interval + Interval.thirtyMin.rawValue
        let urlString = Constants.baseEndpoint + function + symbol + interval + Constants.apiKey
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
    
    public func getSixtyMinIntraday(function: Function, symbol: String, completionHandler: @escaping (Result<StockSixtyMin, Error>) -> Void) {
        let function = Constants.function + function.rawValue
        let symbol = Constants.symbol + symbol
        let interval = Constants.interval + Interval.sixtyMin.rawValue
        let urlString = Constants.baseEndpoint + function + symbol + interval + Constants.apiKey
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
    
}


/*
 public func getIntraday(function: Function, symbol: String, interval: Interval, completionHandler: @escaping (Result<StockOneMin, Error>) -> Void) {
     let function = Constants.function + function.rawValue
     let symbol = Constants.symbol + symbol
     let intervals = Constants.interval + interval.rawValue
     let urlString = Constants.baseEndpoint + function + symbol + intervals + Constants.apiKey
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
             switch interval {
             case .oneMin:
                 let result = try JSONDecoder().decode(StockOneMin.self, from: data)
                 print(result)
             case .fiveMin:
                 let result = try JSONDecoder().decode(StockFiveMin.self, from: data)
                 print(result)
             case .fifteenMin:
                 let result = try JSONDecoder().decode(StockFifteenMin.self, from: data)
                 print(result)
             case .thirtyMin:
                 let result = try JSONDecoder().decode(StockThirtyMin.self, from: data)
                 print(result)
             case .sixtyMin:
                 let result = try JSONDecoder().decode(StockSixtyMin.self, from: data)
                 print(result)
             }
         } catch {
             print(error)
             completionHandler(.failure(error))
         }
     }
     task.resume()
 }
 */
