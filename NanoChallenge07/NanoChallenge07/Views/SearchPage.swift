//
//  TabCellView.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 24/06/24.
//

import SwiftUI

struct SearchPage: View {
    @ObservedObject var vm: SearchPageViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                // Search Bar
                SearchBar(text: $vm.textToSearch, isSearching: vm.isSearching)
                
                VStack {
                    if vm.textToSearch.isEmpty {
                        EmptyStateView()
                    } else if vm.isSearching {
                        LoadingStateView()
                    } else {
                        ScrollView {
                            LazyVStack {
                                ForEach(vm.result.Results, id: \.self) { item in
                                    if item.UrlType == "Item" {
                                        NavigationLink {
                                            DetailPageView(vm: DetailPageViewModel(network: NetworkingManager.shared), item: item)
                                                .padding(.vertical, 8)
                                                .padding(.horizontal)
                                        } label: {
                                            TabCellView(item: item)
                                                .padding(.vertical, 8)
                                                .padding(.horizontal)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .padding(.horizontal)
                                        .padding(.vertical, 4)
                                    }
                                }
                            }
                            .padding(.top)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchPage(vm: SearchPageViewModel(network: NetworkingManager.mock))
}
