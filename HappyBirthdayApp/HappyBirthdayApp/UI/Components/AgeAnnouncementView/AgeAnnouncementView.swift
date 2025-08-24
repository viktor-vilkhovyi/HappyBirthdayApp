//
//  AgeAnnouncementView.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

struct AgeAnnouncementView: View {
    
    struct Age {
        let value: Int
        let unit: String
    }
    
    let fullName: String
    let age: Age
    
    var body: some View {
        VStack(spacing: 13) {
            makeMainTextView("TODAY \(fullName.uppercased()) IS")

            HStack(spacing: 22) {
                Image(.leftSwirls)
                
                DigitImages(number: age.value)
                
                Image(.rightSwirls)
            }
            
            makeMainTextView("\(age.unit.uppercased()) OLD!", lineLimit: 1)
                .padding(.top, 1)
        }
        .padding(.top, 20)
    }
    
    private func makeMainTextView(_ text: String, lineLimit: Int = 2) -> some View {
        Text(text)
            .typography(font: .bentonSans(.w500, size: 21), lineHeight: 29, letterSpacing: -0.42)
            .foregroundStyle(.brandNavy)
            .multilineTextAlignment(.center)
            .lineLimit(lineLimit)
    }
}
