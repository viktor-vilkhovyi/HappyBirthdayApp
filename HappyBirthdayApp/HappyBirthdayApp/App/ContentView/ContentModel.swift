//
//  Untitled.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

protocol IContentModel: IHappyBirthdayCardRouter {
    var path: [ContentRoute] { get set }
}

@Observable
final class ContentModel: IContentModel {
    
    var path: [ContentRoute] = []
    
    func pop() {
        _ = path.popLast()
    }
    
    func push(_ route: ContentRoute) {
        path.append(route)
    }
    
    // MARK: - IHappyBirthdayCardRouter
    func perform(_ route: HappyBirthdayCardRoute) {
        push(.happyBirthdayCard(route))
    }
}
