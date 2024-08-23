//
//  ServerBoardInfo.swift
//  NanoChallenge07
//
//  Created by Luca Lacerda on 23/08/24.
//

import Foundation

struct Materia: Codable {
    let slotID: Int
    let materiaID: Int
}

struct Listing: Codable {
    let lastReviewTime: TimeInterval
    let pricePerUnit: Int
    let quantity: Int
    let stainID: Int
    let creatorName: String
    let creatorID: String?
    let hq: Bool
    let isCrafted: Bool
    let listingID: String
    let materia: [Materia]
    let onMannequin: Bool
    let retainerCity: Int
    let retainerID: String
    let retainerName: String
    let sellerID: String?
    let total: Int
    let tax: Int
}

struct RecentHistory: Codable {
    let hq: Bool
    let pricePerUnit: Int
    let quantity: Int
    let timestamp: TimeInterval
    let onMannequin: Bool
    let buyerName: String
    let total: Int
}

struct StackSizeHistogram: Codable {
    let size: Int
}

struct MarketData: Codable {
    let itemID: Int
    let worldID: Int
    let lastUploadTime: TimeInterval
    let listings: [Listing]
    let recentHistory: [RecentHistory]
    let currentAveragePrice: Double
    let currentAveragePriceNQ: Double
    let currentAveragePriceHQ: Double
    let regularSaleVelocity: Double
    let nqSaleVelocity: Double
    let hqSaleVelocity: Double
    let averagePrice: Double
    let averagePriceNQ: Double
    let averagePriceHQ: Double
    let minPrice: Int
    let minPriceNQ: Int
    let minPriceHQ: Int
    let maxPrice: Int
    let maxPriceNQ: Int
    let maxPriceHQ: Int
    let stackSizeHistogram: [String: Int]
    let stackSizeHistogramNQ: [String: Int]
    let stackSizeHistogramHQ: [String: Int]
    let worldName: String
    let listingsCount: Int
    let recentHistoryCount: Int
    let unitsForSale: Int
    let unitsSold: Int
}
