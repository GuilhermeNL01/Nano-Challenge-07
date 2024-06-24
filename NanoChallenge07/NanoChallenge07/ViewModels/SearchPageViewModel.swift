//
//  SearchPageViewModel.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 24/06/24.
//

import Foundation

@MainActor
class SearchPageViewModel: ObservableObject {
    @Published var textToSearch = ""
    @Published var result:Result = Result(Results: [])
    var network = NetworkManager()
    
    func search(){
        Task{
            do{
                result = try await network.fetchItems(item:textToSearch)
            } catch {
                print(error)
            }
        }
    }
}

