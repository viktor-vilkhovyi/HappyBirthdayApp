//
//  BirthdateTemplateConfig.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 23.08.2025.
//

import SwiftUI

struct BirthdateTemplateConfig: Identifiable {
   
    let id = UUID()
    let image: ImageResource
    let background: Color
    
    static let fox = BirthdateTemplateConfig(
        image: .bgFox,
        background: .brandMintSoft
    )
    
    static var elephant = BirthdateTemplateConfig(
        image: .bgElephant,
        background: .brandSunnySoft
    )
    
    static var pelican = BirthdateTemplateConfig(
        image: .bgPelican,
        background: .brandSkySoft
    )
}
