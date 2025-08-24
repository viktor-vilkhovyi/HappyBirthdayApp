//
//  CreateHappyBirthdayCardModel.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

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
    
    var fullName: String = ""
    var birthdate = Date()
    var image: UIImage?
    
    private let ageService: IAgeFormatting
    weak var router: IHappyBirthdayCardRouter?
    
    init(
        router: IHappyBirthdayCardRouter?,
        ageService: IAgeFormatting = AgeFormatterService()
    ) {
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
