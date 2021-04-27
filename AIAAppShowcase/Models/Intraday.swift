//
//  Intraday.swift
//  AIAAppShowcase
//
//  Created by Jacob Andrean on 24/04/21.
//

import Foundation

struct StockOneMin: Codable {
    let metaData: MetaData
    let timeSeries: [String: TimeSeries]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries = "Time Series (1min)"
    }
}

struct StockFiveMin: Codable {
    let metaData: MetaData
    let timeSeries: [String: TimeSeries]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries = "Time Series (5min)"
    }
}

struct StockFifteenMin: Codable {
    let metaData: MetaData
    let timeSeries: [String: TimeSeries]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries = "Time Series (15min)"
    }
}

struct StockThirtyMin: Codable {
    let metaData: MetaData
    let timeSeries: [String: TimeSeries]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries = "Time Series (30min)"
    }
}

struct StockSixtyMin: Codable {
    let metaData: MetaData
    let timeSeries: [String: TimeSeries]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries = "Time Series (60min)"
    }
}

struct MetaData: Codable {
    let information: String
    let symbol: String
    let lastRefreshed: String
    let interval: String
    let outputSize: String
    let timeZone: String

    private enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefreshed = "3. Last Refreshed"
        case interval = "4. Interval"
        case outputSize = "5. Output Size"
        case timeZone = "6. Time Zone"
    }
}

struct TimeSeries: Codable {
    let open: String
    let high: String
    let low: String
    let close: String
    let volume: String

    private enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
    }
}



