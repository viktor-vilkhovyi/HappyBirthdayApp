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
    let templateScheme: TemplateScheme
    
    var prefixedName: String {
        String(fullName.prefix(20))
    }
}

protocol IPreviewHappyBirthdayCardModel {
    var mainImage: UIImage? { get set }
    var details: HappyBirthdayCardDetails { get set }
    func backButtonTapped()
}

@Observable
final class PreviewHappyBirthdayCardModel: IPreviewHappyBirthdayCardModel {
    
    var details: HappyBirthdayCardDetails
    weak var router: IHappyBirthdayCardRouter?
    private var store: IHappyBirthdayCardStoreService
    
    var mainImage: UIImage? {
        get { store.mainImage }
        set { store.mainImage = newValue }
    }
    
    init(
        router: IHappyBirthdayCardRouter?,
        details: HappyBirthdayCardDetails,
        store: IHappyBirthdayCardStoreService = HappyBirthdayCardStoreService()
    ) {
        self.router = router
        self.details = details
        self.store = store
    }
    
    func backButtonTapped() {
        router?.pop()
    }
}
