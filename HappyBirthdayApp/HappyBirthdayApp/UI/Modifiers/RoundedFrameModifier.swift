//
//  RoundedFrameModifier.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

struct RoundedFrameModifier: ViewModifier {
    let cornerRadius: CGFloat
    let fillColor: Color
    let strokeColor: Color
    let lineWidth: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(fillColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeColor, lineWidth: lineWidth)
            )
    }
}

extension View {
    
    func roundedFrame(
        cornerRadius: CGFloat,
        fillColor: Color,
        strokeColor: Color,
        lineWidth: CGFloat = 1
    ) -> some View {
        modifier(
            RoundedFrameModifier(
                cornerRadius: cornerRadius,
                fillColor: fillColor,
                strokeColor: strokeColor,
                lineWidth: lineWidth
            )
        )
    }
}
