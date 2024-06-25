import SwiftUI

struct SearchPage: View {
    @ObservedObject var vm: SearchPageViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                // Search Bar
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
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        )
                        .disabled(vm.isSearching)
                        .padding(.horizontal)
                }
                .padding(.top)
                
                // Results
                VStack {
                    if vm.isSearching {
                        Spacer()
                        ProgressView("Searching...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(1.5)
                        Spacer()
                    } else {
                        
                        ScrollView{
                            LazyVStack {
                                ForEach(vm.result.Results, id: \.self) { item in
                                    if item.UrlType == "Item"{
                                        NavigationLink {
                                            DetailPageView(vm: DetailPageViewModel(network: NetworkingManager.shared),item: item)
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
