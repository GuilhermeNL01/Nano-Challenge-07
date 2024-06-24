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
    var network = NetworkingManager()
    
    func search(){
        guard !textToSearch.isEmpty else { return }
        Task{
            do{
                result = try await network.request(.searchItem(textToSearch), type: Result.self)
            } catch {
                print(error)
            }
        }
    }
}

