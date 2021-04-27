//
//  DailyAdjusted.swift
//  AIAAppShowcase
//
//  Created by Jacob Andrean on 26/04/21.
//

import Foundation

struct StockDaily: Codable {
    let metaData: MetaDataDaily
    let timeSeries: [String: TimeSeriesDaily]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries = "Time Series (Daily)"
    }
}

struct MetaDataDaily: Codable {
    let information: String
    let symbol: String
    let lastRefreshed: String
    let outputSize: String
    let timeZone: String

    private enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefreshed = "3. Last Refreshed"
        case outputSize = "4. Output Size"
        case timeZone = "5. Time Zone"
    }
}

struct TimeSeriesDaily: Codable {
    let open: String
    let high: String
    let low: String
    let close: String
    let adjustedClose: String
    let volume: String
    let dividendAmount: String
    let splitCoefficient: String

    private enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case adjustedClose = "5. adjusted close"
        case volume = "6. volume"
        case dividendAmount = "7. dividend amount"
        case splitCoefficient = "8. split coefficient"
    }
}

