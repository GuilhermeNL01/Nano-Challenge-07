//
//  DetailPageViewModel.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 24/06/24.
//

import Foundation

@MainActor
class DetailPageViewModel:ObservableObject {
    
    var searchedPrices:[MarketInfo] = []
    @Published var prices:[MarketInfo] = []
    @Published var iteminfo:ItemInfo = ItemInfo(ID: 0, Name: "", IsUntradable: 0, IconHD: "")
    @Published var selectedDataCenter:DataCenter = DataCenter(name: "Select Data Center", region: "", worlds: [])
    
    @Published var dataCenters:[DataCenter] = []
    @Published var worlds:[World] = []
    var network = NetworkingManager.shared
    
    func searchDataCenter() async{
        Task{
            do{
                dataCenters = try await network.request(Endpoint.datacenters, type: [DataCenter].self)
            }catch{
                print(error)
            }
        }
    }
    
    func searchWorlds() async{
        Task{
            do{
                worlds = try await network.request(Endpoint.worlds, type: [World].self)
            }catch{
                print(error)
            }
        }
    }
    
    func searchInfo(info:Int) async{
        Task{
            do{
                iteminfo = try await network.request(.itemInfo(info), type: ItemInfo.self)
            }catch{
                print(error)
            }
        }
    }
    
    func searchMarketInfo() {
        prices = []
        searchedPrices = []
        Task{
            do{
                for world in worlds {
                    if selectedDataCenter.worlds.contains(world.id) {
                        searchedPrices.append(
                            try await network.request(Endpoint.itemPriceForWorld(world.id, iteminfo.ID), type: MarketInfo.self)
                            
                        )
                    }
                }
                searchedPrices.sort(by: {$0.minPrice < $1.minPrice})
                prices = searchedPrices
            }catch{
                print(error)
            }
        }
    }
}
