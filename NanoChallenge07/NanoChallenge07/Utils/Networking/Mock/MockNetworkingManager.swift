//
//  MockNetworkingManager.swift
//  NanoChallenge07
//
//  Created by Fabio Freitas on 25/06/24.
//

import Foundation

final class MockNetworkingManager: NetworkManager {
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        switch endpoint {
        case .searchItem(_):
            return Result(Results: [ItemSearch(ID: 1089, Icon: "/i/000000/000405.png", Name: "potent blinding potion", UrlType: "Item")]) as! T
        case .itemInfo(_):
            return ItemInfo(ID: 4585, Name: "Potent Blinding Potion", IsUntradable: 0, IconHD: "/i/020000/020685_hr1.png") as! T
        case .datacenters:
            return [DataCenter(name: "Elemental", region: "Japan", worlds: [45, 49, 50, 58, 68, 72, 90, 94, 123, 789]), DataCenter(name: "Gaia", region: "Japan", worlds: [43, 46, 51, 59, 69, 76, 92, 98, 123, 456]), DataCenter(name: "Mana", region: "Japan", worlds: [23, 28, 44, 47, 48, 61, 70, 96, 123, 456, 789])] as! T
        case .worlds:
            return [World(id: 123, name: "world"), World(id: 456, name: "world2"), World(id: 789, name: "world3")] as! T
        case .itemPriceForWorld(let worldId, _):
            return MarketInfo(worldID: worldId, minPrice: Int.random(in: 1...10000)) as! T
        }
    }
}
