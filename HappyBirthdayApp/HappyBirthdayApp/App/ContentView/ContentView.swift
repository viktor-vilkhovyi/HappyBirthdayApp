//
//  ContentView.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

struct ContentView<Model: IContentModel>: View {

    @State var model: Model
    
    var body: some View {
        NavigationStack(path: $model.path) {
            VStack(spacing: 24) {
                Text("Welcome to Happy Birthday App!")
                
                Button(action: { model.perform(.createHappyBirthdayCard) }) {
                    Text("Create Happy Birthday Card")
                }
            }
            .navigationDestination(for: ContentRoute.self) { route in
                    switch route {
                    case .happyBirthdayCard(let route):
                        route.navigationDestination(using: model)
                }
            }
        }
    }
}

#Preview {
    ContentView(model: ContentModel())
}


