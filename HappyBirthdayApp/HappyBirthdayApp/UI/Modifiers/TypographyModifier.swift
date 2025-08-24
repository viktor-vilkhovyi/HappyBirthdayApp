//
//  TypographyModifier.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

struct TypographyModifier: ViewModifier {
    let font: UIFont
    let lineHeight: CGFloat
    var tracking: CGFloat?
    var letterSpacing: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .font(Font(font))
            .kerning(letterSpacing)
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, (lineHeight - font.lineHeight) / 2)
            .tracking(tracking ?? 0)
    }
}

extension View {
    
    func typography(
        font: UIFont,
        lineHeight: CGFloat,
        tracking: CGFloat? = nil,
        letterSpacing: CGFloat = 0
    ) -> some View {
        modifier(
            TypographyModifier(
                font: font,
                lineHeight: lineHeight,
                tracking: tracking,
                letterSpacing: letterSpacing
            )
        )
    }
}
