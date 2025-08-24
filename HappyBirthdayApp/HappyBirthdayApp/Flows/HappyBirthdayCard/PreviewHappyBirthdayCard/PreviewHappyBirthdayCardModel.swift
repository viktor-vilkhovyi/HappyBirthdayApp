//
//  PreviewHappyBirthdayCardModel.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

struct TemplateScheme: Hashable {
    let templateConfig: BirthdateTemplateConfig
    let avatarScheme: RoundedAvatarColorScheme
}

struct HappyBirthdayCardDetails: Hashable {
    let fullName: String
    let age: AgeAnnouncementView.Age
    var image: UIImage?
    let templateScheme: TemplateScheme
}

protocol IPreviewHappyBirthdayCardModel {
    var details: HappyBirthdayCardDetails { get set }
    func backButtonTapped()
}

@Observable
final class PreviewHappyBirthdayCardModel: IPreviewHappyBirthdayCardModel {
    
    var details: HappyBirthdayCardDetails
    weak var router: IHappyBirthdayCardRouter?
    
    init(
        router: IHappyBirthdayCardRouter?,
        details: HappyBirthdayCardDetails
    ) {
        self.router = router
        self.details = details
    }
    
    func backButtonTapped() {
        router?.pop()
    }
}
