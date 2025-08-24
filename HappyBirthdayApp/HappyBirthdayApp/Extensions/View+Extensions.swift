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

// MARK: - Position element using degrees

extension View {
   
    func circleOverlay<Overlay: View>(
        at angleDegrees: Double = 45,
        @ViewBuilder overlay: @escaping Resolver<Overlay>
    ) -> some View {
        self.overlay {
            GeometryReader { geo in
                let size = min(geo.size.width, geo.size.height)
                let radius = size / 2
                let rad = angleDegrees * .pi / 180
                let dx = cos(rad) * radius
                let dy = -sin(rad) * radius

                overlay()
                    .position(x: geo.size.width/2 + dx,
                              y: geo.size.height/2 + dy)
            }
        }
    }
}

