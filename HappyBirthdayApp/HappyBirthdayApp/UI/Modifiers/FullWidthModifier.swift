//
//  FullWidthModifier.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 23.08.2025.
//

import SwiftUI

struct FullWidthModifier: ViewModifier {
    let isFullWidth: Bool
    var minHeight, fixedHeight: CGFloat?
    var insets: EdgeInsets = .zero

    func body(content: Content) -> some View {
        let sized = applyHeight(to: content)
        
        if isFullWidth {
            sized
                .frame(maxWidth: .infinity, minHeight: minHeight)
                .padding(.top, insets.top)
                .padding(.bottom, insets.bottom)
        } else {
            sized
                .frame(minHeight: minHeight)
                .padding(insets)
        }
    }
    
    @ViewBuilder
    private func applyHeight(to content: Content) -> some View {
        if let fixedHeight {
            content.frame(height: fixedHeight)
        } else {
            content
        }
    }
}
