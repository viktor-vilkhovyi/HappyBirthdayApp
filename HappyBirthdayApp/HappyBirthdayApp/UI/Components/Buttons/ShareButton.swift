//
//  ShareButton.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 23.08.2025.
//

import SwiftUI

struct ShareButton: View {
    
    var title: String = "Share"
    let action: Handler
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 3) {
                Text(title)
                    .padding(.top, 4)
                
                Image(.icShare)
                    .renderingMode(.template)
            }
        }
        .primaryButton(
            isFullWidth: false,
            state: .brandRed,
            insets: .init(
                top: 8,
                leading: 21,
                bottom: 10,
                trailing: 12
            )
        )
    }
}

#Preview {
    ShareButton(title: "Share", action: { })
}

