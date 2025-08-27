//
//  RoundedAvatarView.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 23.08.2025.
//

import SwiftUI

struct RoundedAvatarView: View {
    
    var showCameraButton: Bool = true
    var size: CGFloat = 222
    var lineWidth: CGFloat = 7
    let colorScheme: RoundedAvatarColorScheme
    @Binding var image: UIImage?
    
    var body: some View {
        PhotoCaptureView(image: $image) { openChooser in
            makeImagePlaceholderView()
                .circleOverlay(at: 45) {
                    makeCameraButtonView(openChooser)
                        .visible(showCameraButton)
                }
        }
    }
    
    private func makeCameraButtonView(_ action: @escaping Handler) -> some View {
        Button(action: action) {
            ZStack {
                Image(.icPhotoWhitePlus)
                    .padding(.top, 8)
                    .padding(.trailing, 4)
                    .padding(.bottom, 6)
                    .padding(.leading, 9)
            }
            .frame(width: 36, height: 36)
            .background(colorScheme.stroke)
            .clipShape(Circle())
        }
        .buttonStyle(ScaledButtonStyle(scaled: 1.2))
    }
    
    private func makeImagePlaceholderView() -> some View {
        ZStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            } else {
                Image(.icBabyPlaceholder)
                    .renderingMode(.template)
                    .foregroundStyle(colorScheme.stroke)
            }
        }
        .modifier(
            RoundedAvatarModifier(
                size: size,
                strokeColor: colorScheme.stroke,
                fillColor: image == nil ? .clear : colorScheme.fill,
                lineWidth: lineWidth
            )
        )
    }
}

#Preview {
    RoundedAvatarView(colorScheme: .sunny, image: .constant(nil))
}
