//
//  DetailPageView.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 24/06/24.
//

import SwiftUI

struct DetailPageView: View {
    @ObservedObject var vm = DetailPageViewModel()
    var item: ItemSearch
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    AsyncImage(url: URL(string:"https://xivapi.com/\(vm.iteminfo.IconHD)")){ image in
                        image.resizable()
                            .frame(width: 80,height: 80)
                            .scaledToFill()
                            .clipShape(Circle())
                            .shadow(color: .black, radius: 10)
                        
                    } placeholder: {
                        ProgressView()
                    }
                    .padding()
                    Text("\(vm.iteminfo.Name)")
                        .bold()
                    HStack{
                        Picker("Please choose a data center", selection: $vm.selectedDataCenter) {
                            ForEach(vm.dataCenters, id: \.self) { data in
                                Text(data.name)
                            }
                        }
                    }
                    .padding()
                }.padding(40)
                ScrollView{
                    if vm.iteminfo.IsUntradable == 1 {
                        Text("untradable")
                    } else {
                        if vm.prices != [] {
                            ForEach(vm.prices, id: \.self){ data in
                                NavigationLink {
                                    
                                } label: {
                                    PriceTabCell(worlds: vm.worlds, data: data)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        } else {
                            ProgressView()
                        }
                    }
                }
            }
            .onChange(of: vm.selectedDataCenter) {
                vm.searchMarketInfo()
            }
            .task {
                await vm.searchInfo(info: item.ID)
                await vm.searchDataCenter()
                await vm.searchWorlds()
            }
        }
    }
}

#Preview {
    DetailPageView(item: ItemSearch(ID: 40624, Icon: "/i/051000/051510.png", Name: "Imitation Curtained Window", UrlType: "Item"))
}
