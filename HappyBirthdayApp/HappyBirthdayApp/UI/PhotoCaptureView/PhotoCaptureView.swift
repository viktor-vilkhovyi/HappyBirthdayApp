//
//  PhotoCaptureView.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 25.08.2025.
//

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
