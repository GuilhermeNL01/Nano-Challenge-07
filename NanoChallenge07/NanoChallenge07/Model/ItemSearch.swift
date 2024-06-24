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
