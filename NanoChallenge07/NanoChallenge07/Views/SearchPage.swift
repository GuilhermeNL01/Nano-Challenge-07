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
                    HStack {
                        TextField("Pesquisa", text: $vm.textToSearch)
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .overlay(
                                HStack {
                                    Spacer()
                                    if vm.isSearching {
                                        ProgressView()
                                            .padding(.trailing, 8)
                                    } else {
                                        Image(systemName: "magnifyinggglass")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    }
                                }
                            )
                            .disabled(vm.isSearching)
                            .padding(.horizontal)
                    }
                    .padding(.top)
                    
                    VStack {
                        if vm.isSearching {
                            Spacer()
                            ProgressView("Searching")
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                .scaleEffect(1.5)
                            Spacer()
                        } else {
                            if vm.result.Results.isEmpty {
                                Spacer()
                                Text("No results found")
                                    .foregroundColor(.gray)
                                    .padding()
                                Spacer()
                            } else {
                                ScrollView {
                                    LazyVStack {
                                        ForEach(vm.result.Results, id: \.self) { item in
                                            if item.UrlType == "Item" {
                                                NavigationLink(destination: DetailPageView(item: item)) {
                                                    TabCellView(item: item)
                                                        .padding(.vertical, 8)
                                                        .padding(.horizontal)
                                                    
                                                        .background(Color(.systemBackground))
                                                        .cornerRadius(10)
                                                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                                .padding(.horizontal)
                                                .padding(.vertical, 4)
                                            }
                                        }
                                    }
                                }
                                .padding(.top)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    SearchPage()
}
