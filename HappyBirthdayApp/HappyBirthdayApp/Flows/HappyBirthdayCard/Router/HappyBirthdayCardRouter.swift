//
//  HappyBirthdayCardRouter.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

protocol IHappyBirthdayCardRouter: AnyObject {
    func pop()
    func perform(_ route: HappyBirthdayCardRoute)
}

enum HappyBirthdayCardRoute: Hashable {
    case createHappyBirthdayCard
    case previewHappyBirthdayCard(String)
    
    @ViewBuilder
    func navigationDestination(using router: IHappyBirthdayCardRouter) -> some View {
        switch self {
        case .createHappyBirthdayCard:
            CreateHappyBirthdayCardView(model: CreateHappyBirthdayCardModel(router: router))
        case .previewHappyBirthdayCard(let string):
            PreviewHappyBirthdayCardView(model: PreviewHappyBirthdayCardModel(router: router))
        }
    }
}

