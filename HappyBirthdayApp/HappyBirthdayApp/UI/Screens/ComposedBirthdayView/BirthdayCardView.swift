//
//  ComposedBirthdayView.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 23.08.2025.
//

import SwiftUI
import PhotosUI

struct BirthdayCardView: View {
    
    let sharingBirthdayCard: Bool
    @State private var birthdayCardSnapshot: UIImage?
    @State private var showCapturePictureDialog = false
    @State private var showShareBirthdayCardSheet = false
    @State private var showImagePicker = false
    @State private var showCameraPermissionAlert = false
    
    @State var selectedImage: UIImage? = nil
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.brandMintSoft
                .edgesIgnoringSafeArea(.all)
            
            AgeAnnouncementView(
                fullName: "Viktor Vilkhovyi",
                age: .init(value: 3, unit: "month")
            )
            .padding(.horizontal, 75)
            
            makeBottomView()
            makeContentView()
            makeBackButtonView()
        }
        .sheet(isPresented: $showShareBirthdayCardSheet) {
            birthdayCardSnapshot
                .flatMap {  ActivityView(items: [$0]) }
        }
        .confirmationDialog("Choose a photo", isPresented: $showCapturePictureDialog) {
            Button("Take Photo") {
                sourceType = .camera
                showImagePicker = true
            }
            Button("Choose from Library") {
                sourceType = .photoLibrary
                showImagePicker = true
            }
            Button("Cancel", role: .cancel) { }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage, sourceType: sourceType)
        }
        .alert("Camera Access Denied", isPresented: $showCameraPermissionAlert) {
            Button("Go to Settings") { openAppSettings() }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please enable camera access in Settings to take a photo.")
        }
    }
    
    // MARK: - Back Button
    private func makeBackButtonView() -> some View {
        BackButton()
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .padding(.leading, 16)
//            .visible(!sharingBirthdayCard)
    }
    
    // MARK: - Bottom View
    private func makeBottomView() -> some View {
        VStack(spacing: 53) {
            VStack(spacing: 15) {
                RoundedAvatarView(
                    colorScheme: .sunny,
                    image: selectedImage,
                    onCameraTap: sharingBirthdayCard ? nil : avatarCameraButtonTapped
                )
                
                Image(.nanitLogo)
            }
            
            ShareButton(title: "Share the news", action:  shareButtonTapped)
//                .visible(!sharingBirthdayCard)
//                .disabled(selectedImage == nil)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .padding(.top, 15)
        .padding(.bottom, 53)
        .background(
            BirthdateTemplateView(config: .pelican)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
        )
    }
    
    // MARK: - Content View
    private func makeContentView() -> some View {
        EmptyView()
    }
    
    // MARK: - Actions
    
    private func shareButtonTapped() {
        makeBirthdayCardSnapshot()
        
//        actionSheet()
        
//        showShareBirthdayCardSheet = true
        
        let image = BirthdayCardView(
            sharingBirthdayCard: true,
            selectedImage: selectedImage
        )
        .snapshot()
        
        shareImage(image)
    }
    
    @MainActor
    private func makeBirthdayCardSnapshot()  {
        birthdayCardSnapshot = BirthdayCardView(
            sharingBirthdayCard: true,
            selectedImage: selectedImage
        )
        .snapshot()
    }
    
    private func avatarCameraButtonTapped() {
        checkCameraPermission { granted in
            if granted {
                sourceType = .camera
                showCapturePictureDialog = true
            } else {
                showCameraPermissionAlert = true
            }
        }
    }
    
    func checkCameraPermission(completion: @escaping (Bool) -> Void) {
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

    func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
       
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

#Preview {
    BirthdayCardView(sharingBirthdayCard: false)
}
