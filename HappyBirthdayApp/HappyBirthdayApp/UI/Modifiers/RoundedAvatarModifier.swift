//
//  RoundedAvatarModifier.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 23.08.2025.
//

import SwiftUI

struct RoundedAvatarModifier: ViewModifier {
    let size: CGFloat
    let strokeColor: Color
    let fillColor: Color
    let lineWidth: CGFloat

    func body(content: Content) -> some View {
        content
            .frame(width: size, height: size)
            .roundedFrame(
                cornerRadius: size / 2,
                fillColor: fillColor,
                strokeColor: strokeColor,
                lineWidth: lineWidth
            )
    }
}
