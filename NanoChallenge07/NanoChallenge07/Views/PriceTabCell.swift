//
//  PriceTabCell.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 24/06/24.
//

import SwiftUI

struct PriceTabCell: View {
    var worlds: [World]
    var data: MarketInfo
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if let world = worlds.first(where: { $0.id == data.worldID }) {
                    Text(world.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                } else {
                    Text("Unknown World")
                        .font(.headline)
                        .foregroundColor(.red)
                }
                
                if data.minPrice == 0 {
                    Text("No items available")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                } else {
                    Text("\(data.minPrice) gil")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            Image(systemName: data.minPrice == 0 ? "exclamationmark.triangle" : "checkmark.circle")
                .foregroundColor(data.minPrice == 0 ? .red : .green)
        }
        .applyBackground()
    }
}

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

extension View {
    func applyBackground() -> some View {
        self.modifier(BackgroundModifier())
    }
}
