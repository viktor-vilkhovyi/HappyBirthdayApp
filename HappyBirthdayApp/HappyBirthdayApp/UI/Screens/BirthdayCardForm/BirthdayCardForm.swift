//
//  BirthdayCardForm.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI
import PhotosUI

struct BirthdayCardForm: View {
    
    @State private var name = ""
    @State private var birthday = Date()
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var showCapturePictureDialog = false
    @State private var showCameraPermissionAlert = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    private let ageService = AgeFormatterService()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(.nanitLogo)
                    .padding(.top, 20)
                
                VStack(spacing: 16) {
                    TextField("name", text: $name)
                    
                    VStack(spacing: 16) {
                        Text("Select birthday")
                            .font(.headline)
                        
                        Text(displayedAge())
                        
                        DatePicker(
                            "Birthday",
                            selection: $birthday,
                            in: ...Date(),
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .environment(\.locale, Locale(identifier: "en_US"))
                        
                        RoundedAvatarView(
                            colorScheme: .mint,
                            image: selectedImage,
                            onCameraTap: avatarCameraButtonTapped
                        )
                    }
                }
                
                Spacer()
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage, sourceType: sourceType)
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
        .padding(.horizontal, 16)
        .ignoresSafeArea(.keyboard)
        .safeAreaInset(edge: .bottom) {
            Button(action: {  }) {
                Text("Show birthday screen")
            }
            .primaryButton(isFullWidth: true, state: .brandRed)
            .padding()
            .disabled(name.isEmpty)
        }
    }
    
    private func displayedAge() -> String {
        ageService.formattedAge(from: birthday, mode: .full)
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
    BirthdayCardForm()
}
