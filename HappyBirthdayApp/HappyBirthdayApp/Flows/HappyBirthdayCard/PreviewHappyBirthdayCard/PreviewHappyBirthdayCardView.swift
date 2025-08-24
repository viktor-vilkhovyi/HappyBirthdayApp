//
//  PreviewHappyBirthdayCardView.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

struct PreviewHappyBirthdayCardView<Model: IPreviewHappyBirthdayCardModel>: View {
    
    @State var model: Model
    
    var body: some View {
        BirthdateTemplateView(config: .fox) {
            AgeAnnouncementView(
                fullName: "Viktor Vilkhovyi",
                age: .init(value: 38, unit: "years")
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 75)
            .zIndex(1)
            
            RoundedAvatarView(colorScheme: .sunny, image: nil, onCameraTap: { })
            
            VStack(spacing: 53) {
                Image(.nanitLogo) // get position of
                
                ShareButton(title: "Share the news", action: { })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 53)
            .zIndex(1)
            
            BackButton()
        }
    }
}

#Preview {
    PreviewHappyBirthdayCardView(model: PreviewHappyBirthdayCardModel(router: nil))
}
