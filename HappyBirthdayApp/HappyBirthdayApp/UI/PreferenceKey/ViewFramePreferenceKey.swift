//
//  ViewFramePreferenceKey.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 25.08.2025.
//

import SwiftUI

struct ViewFramePreferenceKey: PreferenceKey {
    
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    
    func readFrame(
        in space: CoordinateSpace,
        onChange: @escaping (CGRect) -> Void
    ) -> some View {
        background(
            GeometryReader { geo in
                Color.clear
                    .preference(key: ViewFramePreferenceKey.self,
                                value: geo.frame(in: space))
            }
        )
        .onPreferenceChange(ViewFramePreferenceKey.self, perform: onChange)
    }
}
