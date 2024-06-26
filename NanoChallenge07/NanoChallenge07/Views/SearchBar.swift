//
//  SearchBar.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 26/06/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var isSearching: Bool
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Spacer()
                        if isSearching {
                            ProgressView()
                                .padding(.trailing, 8)
                        } else {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                )
                .disabled(isSearching)
                .padding(.horizontal)
        }
        .padding(.top)
    }
}
