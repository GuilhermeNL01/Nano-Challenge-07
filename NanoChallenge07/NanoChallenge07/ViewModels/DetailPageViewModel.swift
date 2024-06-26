//
//  DetailPageViewModel.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 24/06/24.
//

import Foundation

@MainActor
class DetailPageViewModel:ObservableObject {
    let network: NetworkManager
    
    init(network: NetworkManager) {
        self.network = network
    }
    
    @Published var isLoadingPrices = false
    @Published var prices:[MarketInfo] = []
    @Published var iteminfo: ItemInfo?
    @Published var selectedDataCenter:DataCenter = DataCenter(name: "Select Data Center", region: "Elemental", worlds: [])
    @Published var isLoadingDatacenters = false
    @Published var dataCenters:[DataCenter] = []
    @Published var worlds:[World] = []
    @Published var scrollOffset: CGFloat = 0
    
    func searchDataCenter() async{
        isLoadingDatacenters = true
        do{
            let apiDataCenters = try await network.request(session: .shared, Endpoint.datacenters, type: [DataCenter].self)
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
            let apiWorlds = try await network.request(session: .shared,Endpoint.worlds, type: [World].self)
            worlds = apiWorlds
        }catch{
            print(error)
        }
    }
    
    func searchInfo(info:Int) async{
        do{
            let info = try await network.request(session: .shared, .itemInfo(info), type: ItemInfo.self)
            iteminfo = info
        }catch{
            print(error)
        }
    }
    
    func searchMarketInfo() async {
        isLoadingPrices = true
        prices = []
        let worldsWithinSelectedDatacenter = worlds.filter({ selectedDataCenter.worlds.contains($0.id)})
        do{
            guard let iteminfo else { return }
            let priceSearchResult = try await withThrowingTaskGroup(of: MarketInfo.self) { group in
                for world in worldsWithinSelectedDatacenter {
                    group.addTask {
                        return try await self.network.request(session: .shared, Endpoint.itemPriceForWorld(world.id, iteminfo.ID), type: MarketInfo.self)
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
    
    // Function to calculate the corner radius of the item image
    
    func calculateCornerRadius() -> CGFloat {
        let height: CGFloat = 80 // Height of the image
        let maxCornerRadius = height / 2
        let minCornerRadius: CGFloat = 0
        let scrollThreshold: CGFloat = 200 // Adjust this value based on when you want the transition to happen

        // Calculate the corner radius based on the scroll position
        if scrollOffset < scrollThreshold {
            let percentage = scrollOffset / scrollThreshold
            return maxCornerRadius - (percentage * maxCornerRadius)
        } else {
            return minCornerRadius
        }
    }
}

