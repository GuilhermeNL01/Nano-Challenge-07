//
//  ServerDetailViw.swift
//  NanoChallenge07
//
//  Created by Luca Lacerda on 23/08/24.
//

import SwiftUI

struct ServerDetailView: View {
    
    var infoToShow: MarketInfo
    
    var body: some View {
        ZStack {
            
            Color.black
            
            VStack {
                if let listings = infoToShow.listings {
                    ScrollView {
                        ForEach(listings, id: \.self){ data in
                            ServerDetailTabCell(data: data)
                                .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }.padding()
        }
    }
}

#Preview {
    ServerDetailView(infoToShow: MarketInfo(worldID: 78, minPrice: 0, listings: []))
}
