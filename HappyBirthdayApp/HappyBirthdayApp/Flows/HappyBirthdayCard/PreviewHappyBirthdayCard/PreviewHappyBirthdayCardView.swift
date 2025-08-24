//
//  PreviewHappyBirthdayCardView.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

struct PreviewHappyBirthdayCardView<Model: IPreviewHappyBirthdayCardModel>: View {
    
    var sharing: Bool = false
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
            }
            
            VStack(spacing: 53) {
                Image(.nanitLogo)
                
                ShareButton(title: "Share the news", action: shareButtonTapped)
                    .visible(!sharing)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 53)
            .zIndex(1)
            
            BackButton()
                .zIndex(1)
                .visible(!sharing)
        }
    }
    
    private func shareButtonTapped() {
        screenShot = PreviewHappyBirthdayCardView(
            sharing: true,
            model: model
        )
        .snapshot()
        
        shareImage(screenShot)
    }
    
    private func cameraTapped() {
        
    }
}

#Preview {
    PreviewHappyBirthdayCardView(
        sharing: false,
        model: PreviewHappyBirthdayCardModel(
            router: nil,
            details: .init(
                fullName: "John Doe",
                age: .init(value: 1, unit: "month"),
                templateScheme: .init(templateConfig: .elephant, avatarScheme: .sunny)
            )
        )
    )
}

import SwiftUI
import AVFoundation

struct PhotoCaptureView<Content: View>: View {
    @Binding var image: UIImage?
    let content: (_ openChooser: @escaping () -> Void) -> Content

    @State private var showSourceDialog = false
    @State private var showPicker = false
    @State private var showPermissionAlert = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        content { openChooser() }
            .confirmationDialog("Choose a photo", isPresented: $showSourceDialog) {
                Button("Take Photo") {
                    handleTakePhoto()
                }
                Button("Choose from Library") {
                    sourceType = .photoLibrary
                    showPicker = true
                }
                Button("Cancel", role: .cancel) { }
            }
            .sheet(isPresented: $showPicker) {
                ImagePicker(selectedImage: $image, sourceType: sourceType)
            }
            .alert("Camera Access Denied", isPresented: $showPermissionAlert) {
                Button("Go to Settings") { openAppSettings() }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Please enable camera access in Settings to take a photo.")
            }
    }

    // MARK: - Actions

    private func openChooser() {
        // You can pre-check permission here if you want “Take Photo” to be disabled.
        showSourceDialog = true
    }

    private func handleTakePhoto() {
        checkCameraPermission { granted in
            if granted {
                sourceType = .camera
                showPicker = true
            } else {
                showPermissionAlert = true
            }
        }
    }

    // MARK: - Permissions / Settings

    private func checkCameraPermission(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async { completion(granted) }
            }
        case .denied, .restricted:
            completion(false)
        @unknown default:
            completion(false)
        }
    }

    private func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
