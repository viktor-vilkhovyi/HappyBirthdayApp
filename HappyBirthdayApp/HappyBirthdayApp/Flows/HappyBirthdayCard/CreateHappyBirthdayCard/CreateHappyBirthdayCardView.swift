//
//  CreateHappyBirthdayCardView.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

struct CreateHappyBirthdayCardView<Model: ICreateHappyBirthdayCardModel>: View {
    
    @State var model: Model
    @State private var keyboardObserver = KeyboardObserver()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(.nanitLogo)
                    .padding(.top, 20)
                
                VStack(spacing: 16) {
                    TextField("name", text: $model.fullName)
                    
                    VStack(spacing: 16) {
                        Text("Select birthday")
                            .font(.headline)
                        
                        Text(model.displayedAge())
                        
                        DatePicker(
                            "Birthday",
                            selection: $model.birthdate,
                            in: ...Date(),
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .environment(\.locale, Locale(identifier: "en_US"))
                        
                        PhotoCaptureView(image: $model.image) { openChooser in
                            RoundedAvatarView(
                                colorScheme: .mint,
                                image: model.image,
                                onCameraTap: openChooser
                            )
                        }
                    }
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .ignoresSafeArea(.keyboard)
        .safeAreaInset(edge: .bottom) {
            Button(action:  showBirthdayScreenButtonTapped) {
                Text("Show birthday screen")
            }
            .primaryButton(isFullWidth: true, state: .brandRed)
            .padding()
            .disabled(model.fullName.isEmpty)
        }
    }
    
    private func showBirthdayScreenButtonTapped() {
        keyboardObserver.hideKeyboard(completion: model.showBirthdayScreen)
    }
}

#Preview {
    CreateHappyBirthdayCardView(model: CreateHappyBirthdayCardModel(router: nil))
}
