//
//  PrimaryButtonStyle.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 23.08.2025.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
    enum Size {
        case medium
    }
    
    struct ColorScheme {
        let text: Color
        let background: Color
    }
    
    struct Config {
        var scale: CGFloat = 1
        var opacity: CGFloat = 1
        var color: ColorScheme
    }
    
    struct State {
        let active: Config
        let inactive: Config
        let pressed: Config
    }
    
    var isFullWidth: Bool = true
    var minHeight: CGFloat?
    var fixedHeight: CGFloat?
    var cornerRadius: CGFloat = 21
    var insets: EdgeInsets
    let size: Size
    let state: State
    
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        let config = getCurrentConfig(configuration)
        
        return configuration.label
            .font(getFont(size))
            .foregroundStyle(config.color.text)
            .modifier(makeFrameModifier(config))
            .background(config.color.background)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .opacity(config.opacity)
            .scaleEffect(config.scale)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
    
    private func getCurrentConfig(_ configuration: Configuration) -> Config {
        guard isEnabled else { return state.inactive }
        return configuration.isPressed ? state.pressed : state.active
    }
    
    private func getFont(_ size: Size) -> Font {
        switch size {
        case .medium:
            return .bentonSans(.regular, size: 16)
        }
    }
    
    private func makeFrameModifier(_ config: Config) -> FullWidthModifier {
        FullWidthModifier(
            isFullWidth: isFullWidth,
            minHeight: minHeight,
            insets: insets
        )
    }
}

#Preview {
    ShareButton(title: "Share", action: { })
}

