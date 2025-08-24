//
//  RoundedAvatarColorScheme.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 23.08.2025.
//

import SwiftUI

struct RoundedAvatarColorScheme {
    
    let stroke, fill: Color
    
    static let sunny = RoundedAvatarColorScheme(
        stroke: .brandSunny,
        fill: .brandSunnyLight
    )
    
    static let sky = RoundedAvatarColorScheme(
        stroke: .brandSky,
        fill: .brandSkyLight
    )
    
    static let mint = RoundedAvatarColorScheme(
        stroke: .brandMint,
        fill: .brandMintLight
    )
}
