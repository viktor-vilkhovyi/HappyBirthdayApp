//
//  BackButton.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 23.08.2025.
//

import SwiftUI

struct BackButton: View {
    
    let icon: ImageResource = .icBack
    var action: Handler?
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        Button(action: buttonTapped) {
            Image(icon)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.leading, 16)
    }
    
    private func buttonTapped() {
        if let action {
            action()
        } else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    BackButton(action: nil)
}
