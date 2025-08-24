//
//  PreviewHappyBirthdayCardModel.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

protocol IPreviewHappyBirthdayCardModel {
    func backButtonTapped()
}

@Observable
final class PreviewHappyBirthdayCardModel: IPreviewHappyBirthdayCardModel {
    
    weak var router: IHappyBirthdayCardRouter?
    
    init(router: IHappyBirthdayCardRouter?) {
        self.router = router
    }
    
    func backButtonTapped() {
        router?.pop()
    }
}
