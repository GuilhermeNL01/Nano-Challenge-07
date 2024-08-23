//
//  BackgroundViewModifier.swift
//  NanoChallenge07
//
//  Created by Luca Lacerda on 23/08/24.
//

import SwiftUI

struct BackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGray6))
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            )
            .padding([.horizontal, .vertical], 8)
    }
}
