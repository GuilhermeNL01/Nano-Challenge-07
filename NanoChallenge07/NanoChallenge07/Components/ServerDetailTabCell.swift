//
//  ServerDetailTabCell.swift
//  NanoChallenge07
//
//  Created by Luca Lacerda on 23/08/24.
//

import SwiftUI

struct ServerDetailTabCell: View {
    
    var data: Listing
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text("Price per unit: \(data.pricePerUnit) gil")
                Text("Total price: \(data.total) gil")
                Text("Units: \(data.quantity)")
            }
            
            Spacer()
            
            if data.hq {
                Text("HQ")
            }
            
        }
        .applyBackground()
    }
}
