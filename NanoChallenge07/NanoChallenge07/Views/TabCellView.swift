//
//  TabCellView.swift
//  NanoChallenge07
//
//  Created by Guilherme Nunes Lobo on 24/06/24.
//

import SwiftUI

struct TabCellView: View {
    
    var item: ItemSearch
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string:"https://xivapi.com/\(item.Icon)"))
            Text("\(item.Name)")
                .bold()
            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.gray)
        }
    }
}
