//
//  LoadingStateView.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 26/06/24.
//

import SwiftUI

struct LoadingStateView: View {
    var body: some View {
        Spacer()
        ProgressView("Searching...")
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .scaleEffect(1.5)
        Spacer()
    }
}

#Preview {
    LoadingStateView()
}
