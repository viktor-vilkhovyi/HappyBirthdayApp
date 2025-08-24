//
//  KeyboardObserver.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import UIKit
import Combine

final class KeyboardObserver: ObservableObject {
   
    @Published var height: CGFloat = 0
    @Published var isKeyboardPresented: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    var isVisible: Bool { height > 0 }
    
    init() {
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [weak self] _ in
                self?.isKeyboardPresented = true
            }
            .store(in: &cancellables)

        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] _ in
                self?.isKeyboardPresented = false
            }
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    func hideKeyboard(completion: @escaping Handler) {
        guard isKeyboardPresented else {
            return completion()
        }
        
        UIApplication.endEditing()
        
        DispatchQueue.main
            .asyncAfter(deadline: .now() + 0.35, execute: completion)
    }
}
