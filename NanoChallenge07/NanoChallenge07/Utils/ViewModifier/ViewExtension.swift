//
//  ViewExtension.swift
//  NanoChallenge07
//
//  Created by Luca Lacerda on 23/08/24.
//

import SwiftUI

extension View {
    func applyBackground() -> some View {
        self.modifier(BackgroundModifier())
    }
}
