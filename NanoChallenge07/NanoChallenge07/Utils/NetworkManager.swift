//
//  NetworkManager.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 24/06/24.
//

import Foundation

class NetworkManager {
    
    private func fetchData<T: Decodable>(from endpoint: String, responseType: T.Type) async throws -> T {
        guard let url = URL(string: endpoint) else { throw GHError.invalidURl }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw GHError.invalidREsponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw GHError.invalidData
        }
    }
    
    func fetchItems(item: String) async throws -> Result {
        let endpoint = "https://xivapi.com/search?string=\(item)"
        return try await fetchData(from: endpoint, responseType: Result.self)
    }
    
    func fetchItemInfo(itemId: Int) async throws -> ItemInfo {
        let endpoint = "https://xivapi.com/item/\(itemId)"
        return try await fetchData(from: endpoint, responseType: ItemInfo.self)
    }
    
    func fetchAvailableDataCenters() async throws -> [DataCenter] {
        let endpoint = "https://universalis.app/api/v2/data-centers"
        return try await fetchData(from: endpoint, responseType: [DataCenter].self)
    }
    
    func fetchAvailableWorlds() async throws -> [World] {
        let endpoint = "https://universalis.app/api/v2/worlds"
        return try await fetchData(from: endpoint, responseType: [World].self)
    }
    
    func searchPrices(world: Int, itemId: Int) async throws -> MarketInfo {
        let endpoint = "https://universalis.app/api/v2/\(world)/\(itemId)"
        return try await fetchData(from: endpoint, responseType: MarketInfo.self)
    }
}
