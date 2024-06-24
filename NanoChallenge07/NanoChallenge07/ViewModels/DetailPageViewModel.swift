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
    var network = NetworkManager()
    
    func searchDataCenter() async{
        Task{
            do{
                dataCenters = try await network.fetchAvailableDataCenters()
            }catch{
                print(error)
            }
        }
    }
    
    func searchWorlds() async{
        Task{
            do{
                worlds = try await network.fetchAvailableWorlds()
            }catch{
                print(error)
            }
        }
    }
    
    func searchInfo(info:Int) async{
        Task{
            do{
                iteminfo = try await network.fetchItemInfo(itemId: info)
            }catch{
                print(error)
            }
        }
    }
    
    func searchMarketInfo() async{
        prices = []
        searchedPrices = []
        Task{
            do{
                for world in worlds {
                    if selectedDataCenter.worlds.contains(world.id) {
                        searchedPrices.append(try await network.searchPrices(world: world
                            .id, itemId: iteminfo.ID))
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
