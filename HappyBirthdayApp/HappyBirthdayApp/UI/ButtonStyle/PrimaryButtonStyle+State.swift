//
//  PrimaryButtonStyle.State+Extensions.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 23.08.2025.
//

import SwiftUI

extension PrimaryButtonStyle.State {
    
    static let brandRed = PrimaryButtonStyle.State(
        active: .init(
            color: .init(
                text: .brandWhite,
                background: .brandRed
            )
        ),
        inactive: .init(
            opacity: 0.9,
            color: .init(
                text: Color(UIColor.tertiaryLabel),
                background: Color(UIColor.systemGray5)
            )
        ),
        pressed: .init(
            scale: 0.98,
            color: .init(
                text: .brandWhite,
                background: .brandRed
            )
        )
    )
}
