//
//  PreviewHappyBirthdayCardView.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

struct PreviewHappyBirthdayCardView<Model: IPreviewHappyBirthdayCardModel>: View {
    
    @State private var appLogoFrame: CGRect = .zero
    @State private var avatarSize: CGSize = .zero
    private let avatarViewBottomOffset: CGFloat = 15
    private let parentCoordinateSpace = "parentCoordinateSpace"
    
    private(set) var sharing: Bool = false
    @State private var screenShot: UIImage?
    @State private var selectedImage: UIImage?
    @State var model: Model
    
    var body: some View {
        BirthdateTemplateView(config: model.details.templateScheme.templateConfig) {
            AgeAnnouncementView(
                fullName: model.details.fullName,
                age: model.details.age
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 75)
            .zIndex(1)
            
            PhotoCaptureView(image: $model.details.image) { openChooser in
                RoundedAvatarView(
                    colorScheme: model.details.templateScheme.avatarScheme,
                    image: model.details.image,
                    onCameraTap: sharing ? nil : openChooser
                )
                .readSize { size in
                    avatarSize = size
                }
            }
            .position(avatarCalculatedPosition())

            VStack(spacing: 53) {
                Image(.nanitLogo)
                    .readFrame(in: .named(parentCoordinateSpace)) { frame in
                        appLogoFrame = frame
                    }
                    
                ShareButton(title: "Share the news", action: shareButtonTapped)
                    .visible(!sharing)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 53)
            .zIndex(2)
            
            BackButton()
                .zIndex(1)
                .visible(!sharing)
        }
        .coordinateSpace(name: parentCoordinateSpace)
    }
    
    private func shareButtonTapped() {
        let copy = asSharingCopy()
        screenShot = copy.snapshot()
        
        shareImage(screenShot)
    }
    
    private func asSharingCopy() -> PreviewHappyBirthdayCardView<Model> {
        var copy = self
        copy.sharing = true
        return copy
    }
    
    private func avatarCalculatedPosition() -> CGPoint {
        guard !appLogoFrame.isEmpty else { return .zero }

        let rawX = appLogoFrame.midX
        let rawY = appLogoFrame.minY - avatarSize.height/2 - avatarViewBottomOffset

        return CGPoint(
            x: rawX,
            y: rawY
        )
    }
}

#Preview {
    PreviewHappyBirthdayCardView(
        model: PreviewHappyBirthdayCardModel(
            router: nil,
            details: .init(
                fullName: "John Doe",
                age: .init(value: 1, unit: "month"),
                templateScheme: .init(templateConfig: .fox, avatarScheme: .mint)
            )
        )
    )
}
