//
//  EmptyStateView.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 26/06/24.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        Spacer()
        VStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            Text("Start searching by typing above")
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
        Spacer()
    }
}

#Preview {
    EmptyStateView()
}
