//
//  DigitImages.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

struct DigitImages: View {
    let number: Int
    var spacing: CGFloat = 4

    private var digits: [Int] {
        String(number)
            .compactMap(\.wholeNumberValue)
    }

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(digits.indices, id: \.self) { idx in
                Image(String(digits[idx]))
            }
        }
    }
}

