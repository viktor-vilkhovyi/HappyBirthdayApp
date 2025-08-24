//
//  ViewSizePreferenceKey.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 25.08.2025.
//

import SwiftUI

struct ViewSizePreferenceKey: PreferenceKey {
    
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
}

extension View {
    
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geo in
                Color.clear.preference(
                    key: ViewSizePreferenceKey.self,
                    value: geo.size
                )
            }
        )
        .onPreferenceChange(ViewSizePreferenceKey.self, perform: onChange)
    }
}
