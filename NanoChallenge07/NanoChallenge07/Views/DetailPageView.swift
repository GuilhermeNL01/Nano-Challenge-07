//
//  DetailPageView.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 24/06/24.
//



import SwiftUI

struct DetailPageView: View {
    @ObservedObject var vm: DetailPageViewModel
    var item: ItemSearch
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    AsyncImage(url: URL(string:"https://xivapi.com/\(vm.iteminfo?.IconHD ?? "")")){ image in
                        image.resizable()
                            .frame(width: 80, height: 80)
                            .scaledToFill()
                            .cornerRadius(vm.calculateCornerRadius())
                            .shadow(color: .black, radius: 10)
                    } placeholder: {
                        ProgressView()
                    }
                    .padding()
                    if let iteminfo = vm.iteminfo {
                        Text("\(iteminfo.Name)")
                            .bold()
                    }
                    HStack{
                        if vm.isLoadingDatacenters {
                            ProgressView()
                        } else {
                            Picker("Please choose a data center", selection: $vm.selectedDataCenter) {
                                ForEach(vm.dataCenters, id: \.self) { data in
                                    Text(data.name)
                                }
                            }.pickerStyle(.inline)
                        }
                    }.frame(height: 100)
                }
                
                ScrollView {
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                vm.scrollOffset = geometry.frame(in: .global).minY
                            }
                            .onChange(of: geometry.frame(in: .global).minY) { value in
                                vm.scrollOffset = value
                            }
                    }
                    .frame(height: 0) // Invisible GeometryReader to track offset

                    if vm.isLoadingPrices {
                        ProgressView()
                    } else if let iteminfo = vm.iteminfo, iteminfo.IsUntradable == 1 {
                        Text("untradable")
                    }
                    else {
                        ForEach(vm.prices, id: \.self){ data in
                            NavigationLink {
                                
                            } label: {
                                PriceTabCell(worlds: vm.worlds, data: data)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .onChange(of: vm.selectedDataCenter) { _, newValue in
                guard !vm.selectedDataCenter.region.isEmpty else { return }
                Task {
                    await vm.searchMarketInfo()
                }
            }
            .task {
                _ = await [vm.searchInfo(info: item.ID), vm.searchWorlds(), vm.searchDataCenter()]
            }
        }
    }
}


#Preview {
    DetailPageView(vm: DetailPageViewModel(network: NetworkingManager.mock), item: ItemSearch(ID: 40624, Icon: "/i/051000/051510.png", Name: "Imitation Curtained Window", UrlType: "Item"))
}
