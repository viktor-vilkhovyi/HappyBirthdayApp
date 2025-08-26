//
//  AppStorageImageFile.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 26.08.2025.
//

import SwiftUI

@propertyWrapper
struct AppStorageImageFile {
    private let key: String
    private let format: ImageStorageFormat
    @AppStorage private var storedPath: String?

    init(
        wrappedValue: UIImage? = nil,
        _ key: String,
        format: ImageStorageFormat = .jpg(quality: 0.9)
    ) {
        self.key = key
        self.format = format
        self._storedPath = AppStorage(key)
        
        if let initial = wrappedValue {
            self.wrappedValue = initial
        }
    }

    var wrappedValue: UIImage? {
        get { ImageFileStorage.load(path: storedPath) }
        set {
            if let image = newValue {
                if let newPath = ImageFileStorage.save(image, name: key, format: format) {
                    if newPath != storedPath { ImageFileStorage.delete(path: storedPath) }
                    storedPath = newPath
                }
            } else {
                ImageFileStorage.delete(path: storedPath)
                storedPath = nil
            }
        }
    }
}
