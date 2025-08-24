//
//  Button+Extension.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 23.08.2025.
//

import SwiftUI

extension Button {
    
    func primaryButton(
        isFullWidth: Bool = true,
        size: PrimaryButtonStyle.Size = .medium,
        state: PrimaryButtonStyle.State,
        minHeight: CGFloat? = nil,
        fixedHeight: CGFloat? = nil,
        cornerRadius: CGFloat = 21,
        insets: EdgeInsets = .init(vertical: 10, horizontal: 21)
    ) -> some View {
        buttonStyle(
            PrimaryButtonStyle(
                isFullWidth: isFullWidth,
                minHeight: minHeight,
                fixedHeight: fixedHeight,
                cornerRadius: cornerRadius,
                insets: insets,
                size: size,
                state: state
            )
        )
    }
}
