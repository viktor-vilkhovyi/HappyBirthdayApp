//
//  CreateHappyBirthdayCardView.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

struct CreateHappyBirthdayCardView<Model: ICreateHappyBirthdayCardModel>: View {
    
    @State var model: Model
    
    var body: some View {
        Button(action: { model.showBirthdayScreen() }) {
            Text("Show birthday Screen")
        }
    }
}

#Preview {
    CreateHappyBirthdayCardView(model: CreateHappyBirthdayCardModel(router: nil))
}
