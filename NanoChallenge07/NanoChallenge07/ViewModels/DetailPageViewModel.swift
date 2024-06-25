//
//  DetailPageViewModel.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 24/06/24.
//

import Foundation

@MainActor
class DetailPageViewModel:ObservableObject {
    
    
    @Published var isLoadingPrices = true
    @Published var prices:[MarketInfo] = []
    @Published var iteminfo:ItemInfo = ItemInfo(ID: 0, Name: "", IsUntradable: 0, IconHD: "")
    @Published var selectedDataCenter:DataCenter = DataCenter(name: "Select Data Center", region: "Elemental", worlds: [])
    @Published var isLoadingDatacenters = false
    @Published var dataCenters:[DataCenter] = []
    @Published var worlds:[World] = []
    var network = NetworkingManager.shared
    
    func searchDataCenter() async{
        isLoadingDatacenters = true
        do{
            let apiDataCenters = try await network.request(Endpoint.datacenters, type: [DataCenter].self)
            dataCenters = apiDataCenters
            if let first = dataCenters.first {
                selectedDataCenter = first
            }
            isLoadingDatacenters = false
        }catch{
            print(error)
            isLoadingDatacenters = false
        }
    }
    
    func searchWorlds() async{
        do{
            worlds = try await network.request(Endpoint.worlds, type: [World].self)
        }catch{
            print(error)
        }
    }
    
    func searchInfo(info:Int) async{
        do{
            iteminfo = try await network.request(.itemInfo(info), type: ItemInfo.self)
        }catch{
            print(error)
        }
    }
    
    func searchMarketInfo() async {
        isLoadingPrices = true
        prices = []
        let worldsWithinSelectedDatacenter = worlds.filter({ selectedDataCenter.worlds.contains($0.id)})
        do{
            let priceSearchResult = try await withThrowingTaskGroup(of: MarketInfo.self) { group in
                for world in worldsWithinSelectedDatacenter {
                    group.addTask {
                        return try await self.network.request(Endpoint.itemPriceForWorld(world.id, self.iteminfo.ID), type: MarketInfo.self)
                    }
                }
                var searchedPrices: [MarketInfo] = []
                for try await result in group {
                    searchedPrices.append(result)
                }
                return searchedPrices
            }
            prices = priceSearchResult.sorted(by: {$0.minPrice < $1.minPrice})
            isLoadingPrices = false
        }catch{
            print(error)
            isLoadingPrices = false
        }
    }
}
