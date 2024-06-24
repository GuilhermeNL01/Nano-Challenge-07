//
//  PriceTabCell.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 24/06/24.
//

import SwiftUI

struct PriceTabCell: View {
    var worlds:[World]
    var data:MarketInfo
    var body: some View {
        HStack{
            if let world = worlds.first(where: { world in world.id == data.worldID}){
                    Text(world.name)
            }
            if data.minPrice == 0 {
                Text("No items available")
            } else {
                Text("\(data.minPrice) gil")
            }
            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.gray)
        }
    }
}


