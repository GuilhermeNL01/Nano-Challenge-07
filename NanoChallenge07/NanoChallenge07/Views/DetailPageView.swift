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
    
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    AsyncImage(url: URL(string: "https://xivapi.com/\(vm.iteminfo.IconHD)")) { image in
                        image.resizable()
                            .frame(width: 80, height: 80)
                            .scaledToFill()
                            .cornerRadius(calculateCornerRadius())
                            .shadow(color: .black, radius: 10)
                    } placeholder: {
                        ProgressView()
                    }
                    .padding()
                    
                    Text("\(vm.iteminfo.Name)")
                        .bold()

                    HStack {
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
                                self.scrollOffset = geometry.frame(in: .global).minY
                            }
                            .onChange(of: geometry.frame(in: .global).minY) { value in
                                self.scrollOffset = value
                            }
                    }
                    .frame(height: 0) // Invisible GeometryReader to track offset

                    if vm.isLoadingPrices {
                        ProgressView()
                    } else if vm.iteminfo.IsUntradable == 1 {
                        Text("Untradable")
                    } else {
                        ForEach(vm.prices, id: \.self) { data in
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
    
    private func calculateCornerRadius() -> CGFloat {
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


#Preview {
    DetailPageView(vm: DetailPageViewModel(network: NetworkingManager.mock), item: ItemSearch(ID: 40624, Icon: "/i/051000/051510.png", Name: "Imitation Curtained Window", UrlType: "Item"))
}
