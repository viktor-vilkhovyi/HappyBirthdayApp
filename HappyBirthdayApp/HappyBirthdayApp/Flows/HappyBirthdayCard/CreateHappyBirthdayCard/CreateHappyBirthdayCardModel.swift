//
//  CreateHappyBirthdayCardModel.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

protocol ICreateHappyBirthdayCardModel {
    func showBirthdayScreen()
}

@Observable
final class CreateHappyBirthdayCardModel: ICreateHappyBirthdayCardModel {
    
    weak var router: IHappyBirthdayCardRouter?
    
    init(router: IHappyBirthdayCardRouter?) {
        self.router = router
    }
    
    func showBirthdayScreen() {
        router?.perform(.previewHappyBirthdayCard(""))
    }
}
