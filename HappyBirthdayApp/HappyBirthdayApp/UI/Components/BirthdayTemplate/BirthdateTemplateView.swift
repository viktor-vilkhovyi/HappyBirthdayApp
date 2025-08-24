//
//  BirthdateTemplateView.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 23.08.2025.
//

import SwiftUI

struct BirthdateTemplateView<Content: View>: View {
    
    let config: BirthdateTemplateConfig
    @ViewBuilder let content: Resolver<Content>
    
    init(
        config: BirthdateTemplateConfig,
        @ViewBuilder content: @escaping Resolver<Content> = { EmptyView() }
    ) {
        self.config = config
        self.content = content
    }
    
    var body: some View {
        ZStack {
            config.background
                .edgesIgnoringSafeArea(.all)
            
            content()
            
            Image(config.image)
                .resizable()
                .ignoresSafeArea()
                .allowsHitTesting(false)
        }
    }
}

#Preview {
    BirthdateTemplateView(config: .fox)
}
