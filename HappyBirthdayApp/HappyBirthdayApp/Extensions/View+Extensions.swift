//
//  View+Extensions.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import SwiftUI

extension View {
    
    func visible(_ visible: Bool) -> some View {
        opacity(visible ? 1 : 0)
    }
    
    func snapshot(
        scale: CGFloat = UIScreen.main.scale,
        size: CGSize = UIScreen.main.bounds.size
    ) -> UIImage? {
        let renderer = ImageRenderer(content: self)
        renderer.scale = scale
        renderer.proposedSize = .init(size)
        return renderer.uiImage
    }
}

// MARK: - Share Activity
extension View {
    
    func shareImage(_ image: UIImage?) {
        shareActivity(image)
    }
    
    func shareActivity(_ item: Any?) {
        guard let item else { return }
        let vc = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        UIApplication.rootViewController?.present(vc, animated: true)
    }
}
