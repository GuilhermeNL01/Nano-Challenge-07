//
//  NetworkManager.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 24/06/24.
//

import Foundation

class NetworkManager {
    
    func fetchItems(item:String) async throws -> Result{
        var result = Result(Results: [])
        let endpoint = "https://xivapi.com/search?string=\(item)"
        guard let url = URL(string: endpoint) else { throw GHError.invalidURl }
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            print("\(response)")
            throw GHError.invalidREsponse
        }
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            result = try decoder.decode(Result.self, from: data)
            return result
        } catch {
            print("result")
            throw GHError.invalidData
        }
    }
    
    func fetchItemInfo(itemId: Int) async throws -> ItemInfo{
        let endpoint = "https://xivapi.com/item/\(itemId)"
        guard let url = URL(string: endpoint) else { throw GHError.invalidURl }
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            print("\(response)")
            throw GHError.invalidREsponse
        }
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let data = try decoder.decode(ItemInfo.self, from: data)
            return data
        } catch {
            throw GHError.invalidData
        }
    }
    
    func fetchAvailableDataCenters() async throws -> [DataCenter]{
        var result:[DataCenter] = []
        let endpoint = "https://universalis.app/api/v2/data-centers"
        guard let url = URL(string: endpoint) else { throw GHError.invalidURl }
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            print("\(response)")
            throw GHError.invalidREsponse
        }
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            result = try decoder.decode([DataCenter].self, from: data)
            return result
        } catch {
            throw GHError.invalidData
        }
    }
    
    func fetchAvailableWorlds() async throws -> [World]{
        var result:[World] = []
        let endpoint = "https://universalis.app/api/v2/worlds"
        guard let url = URL(string: endpoint) else { throw GHError.invalidURl }
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            print("\(response)")
            throw GHError.invalidREsponse
        }
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            result = try decoder.decode([World].self, from: data)
            return result
        } catch {
            throw GHError.invalidData
        }
    }
    
    func searchPrices(world:Int, itemId:Int) async throws -> MarketInfo{
        var result:MarketInfo = MarketInfo(worldID: world, minPrice: 0)
        let endpoint = "https://universalis.app/api/v2/\(world)/\(itemId)"
        guard let url = URL(string: endpoint) else { throw GHError.invalidURl }
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            print("\(response)")
            throw GHError.invalidREsponse
        }
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            result = try decoder.decode(MarketInfo.self, from: data)
            return result
        } catch {
            throw GHError.invalidData
        }
    }
}
