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
        Button(action: { model.backButtonTapped() }) {
            Text("Move back from preview")
        }
    }
}

#Preview {
    PreviewHappyBirthdayCardView(model: PreviewHappyBirthdayCardModel(router: nil))
}
