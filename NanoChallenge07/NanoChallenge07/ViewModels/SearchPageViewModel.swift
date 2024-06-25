//
//  SearchPageViewModel.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 24/06/24.
//

import Foundation
import Combine

@MainActor
class SearchPageViewModel: ObservableObject {
    @Published var textToSearch = ""
    @Published var isSearching = false
    @Published var result:Result = Result(Results: [])
    let network = NetworkingManager.shared
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $textToSearch
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self, !self.textToSearch.isEmpty else { return }
                self.performSearch()
            }
            .store(in: &cancellables)
    }
    
    func performSearch(){
        guard !textToSearch.isEmpty else { return }
        isSearching = true
        Task{
            do{
                let searchResult = try await network.request(.searchItem(textToSearch.lowercased()), type: Result.self)
                result = searchResult
                isSearching = false
            } catch {
                print(error)
                isSearching = false
            }
        }
    }
}

