//
//  ItemSearch.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 24/06/24.
//

import Foundation

struct ItemInfo: Codable, Hashable {
    var ID:Int
    var Name:String
    var IsUntradable:Int
    var IconHD:String
}

struct ItemSearch: Codable, Hashable {
    var ID:Int
    var Icon:String
    var Name:String
    var UrlType:String
}

struct MarketInfo: Codable, Hashable {
    var worldID:Int
    var minPrice:Int
    let listings: [Listing]?
    
    static func == (lhs: MarketInfo, rhs: MarketInfo) -> Bool {
        return lhs.worldID == rhs.worldID &&
               lhs.minPrice == rhs.minPrice &&
               lhs.listings == rhs.listings
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(worldID)
        hasher.combine(minPrice)
        hasher.combine(listings)
    }
}

struct Listing: Codable, Equatable, Hashable {
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
    
    static func == (lhs: Listing, rhs: Listing) -> Bool {
          return lhs.listingID == rhs.listingID
      }
      
      func hash(into hasher: inout Hasher) {
          hasher.combine(listingID)
      }
}

struct Result: Codable {
    var Results:[ItemSearch]
}

struct DataCenter: Codable, Hashable {
    var name:String
    var region:String
    var worlds:[Int]
}

struct World: Codable, Hashable {
    var id:Int
    var name:String
}
