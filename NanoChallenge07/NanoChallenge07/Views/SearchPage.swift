//
//  SearchPage.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 24/06/24.
//

import SwiftUI

struct SearchPage: View {
    @ObservedObject var vm = SearchPageViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                VStack {
                    TextField("Pesquisa", text: $vm.textToSearch)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                    
                    ScrollView{
                        ForEach(vm.result.Results, id: \.self) { item in
                            if item.UrlType == "Item"{
                                NavigationLink {
                                    DetailPageView(item: item)
                                } label: {
                                    TabCellView(item: item)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
                .padding()
                .onChange(of: vm.textToSearch) { oldValue, newValue in
                    if newValue == ""{
                        vm.result.Results = []
                    } else {
                        vm.search()
                    }
                }
            }
        }
    }
}

#Preview {
    SearchPage()
}


#Preview {
    SearchPage()
}