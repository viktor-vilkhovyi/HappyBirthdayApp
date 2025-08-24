//
//  Font.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 23.08.2025.
//

import SwiftUI

// MARK: - FontWeight
enum FontWeight: Int, CaseIterable {
    case w100 = 100
    case w300 = 300
    case w400 = 400
    case w450 = 450
    case w500 = 500
    case w700 = 700
    case w900 = 900
}

enum BentonSansStyle: String {
    case black      = "BentonSans-Black"
    case bold       = "BentonSans-Bold"
    case book       = "BentonSans-Book"
    case light      = "BentonSans-Light"
    case medium     = "BentonSans-Medium"
    case regular    = "BentonSans-Regular"
    case thin       = "BentonSans-Thin"
    
    init(_ weight: FontWeight) {
        switch weight {
        case .w100: self = .thin
        case .w300: self = .light
        case .w400: self = .regular
        case .w450: self = .book
        case .w500: self = .medium
        case .w700: self = .bold
        case .w900: self = .black
        }
    }
}

// MARK: - Font
extension Font {
    
    static func bentonSans(_ style: BentonSansStyle, size: CGFloat) -> Font {
        .custom(style.rawValue, size: size)
    }
    
    static func bentonSans(_ weight: FontWeight, size: CGFloat) -> Font {
        .custom(BentonSansStyle(weight).rawValue, size: size)
    }
}

// MARK: - UIFont
extension UIFont {
    
    static func bentonSans(_ style: BentonSansStyle, size: CGFloat) -> UIFont {
        UIFont(name: style.rawValue, size: size)!
    }
    
    static func bentonSans(_ weight: FontWeight, size: CGFloat) -> UIFont {
        UIFont(name: BentonSansStyle(weight).rawValue, size: size)!
    }
}
