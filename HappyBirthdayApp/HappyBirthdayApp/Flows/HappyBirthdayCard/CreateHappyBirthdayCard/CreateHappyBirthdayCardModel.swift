//
//  CreateHappyBirthdayCardModel.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

// MARK: Store Service
protocol IHappyBirthdayCardStoreService {
    var fullName: String { get set }
    var birthdate: Date { get set }
    var mainImage: UIImage? { get set }
}

struct HappyBirthdayCardStoreService: IHappyBirthdayCardStoreService {
    @AppStorage("fullName") var fullName: String = ""
    @AppStorage("birthdate") var birthdate = Date()
    @AppStorageImageFile("mainImage", format: .jpg(quality: 9)) var mainImage: UIImage?
}

// MARK: - Model
protocol ICreateHappyBirthdayCardModel {
    var fullName: String { get set }
    var birthdate: Date { get set }
    var image: UIImage? { get set }
    
    func isValid() -> Bool
    func displayedAge() -> String
    func showBirthdayScreen()
}

@Observable
final class CreateHappyBirthdayCardModel: ICreateHappyBirthdayCardModel {
    
    weak var router: IHappyBirthdayCardRouter?
    private let ageService: IAgeFormatting
    private var store: IHappyBirthdayCardStoreService
    
    var fullName: String {
        get { store.fullName }
        set { store.fullName = newValue }
    }
    
    var birthdate: Date {
        get { store.birthdate }
        set { store.birthdate = newValue }
    }
    
    var image: UIImage? {
        get { store.mainImage }
        set { store.mainImage = newValue }
    }
    
    init(
        router: IHappyBirthdayCardRouter?,
        ageService: IAgeFormatting = AgeFormatterService(),
        store: IHappyBirthdayCardStoreService = HappyBirthdayCardStoreService()
    ) {
        self.store = store
        self.router = router
        self.ageService = ageService
    }
    
    func showBirthdayScreen() {
        guard let components = ageService.ageComponents(from: birthdate, now: .now) else {
            return
        }
        
        router?.perform(.previewHappyBirthdayCard(.init(
            fullName: fullName,
            age: .init(value: components.value, unit: components.unitLabel),
            image: image,
            templateScheme: randomTemplateScheme()
        )))
    }
    
    private func randomTemplateScheme() -> TemplateScheme {
        [
            .init(templateConfig: .fox, avatarScheme: .mint),
            .init(templateConfig: .elephant, avatarScheme: .sunny),
            .init(templateConfig: .pelican, avatarScheme: .sky)
        ]
            .randomElement() ?? .init(templateConfig: .fox, avatarScheme: .mint)
    }
    
    func displayedAge() -> String {
        ageService.formattedAge(from: birthdate, now: .now,  mode: .full)
    }
    
    func isValid() -> Bool {
        !fullName.isEmpty && ageService.ageComponents(from: birthdate, now: .now) != nil
    }
}
