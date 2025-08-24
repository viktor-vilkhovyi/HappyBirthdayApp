//
//  ScaledButtonStyle.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 23.08.2025.
//

import SwiftUI

struct ScaledButtonStyle: ButtonStyle {
    
    var scaled: CGFloat = 0.98
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaled : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
