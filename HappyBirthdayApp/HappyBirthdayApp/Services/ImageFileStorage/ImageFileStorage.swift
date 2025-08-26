//
//  ImageFileStorage.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 26.08.2025.
//

import SwiftUI

// MARK: - Storage format

enum ImageStorageFormat {
    case jpg(quality: CGFloat)
    case png

    var fileExtension: String {
        switch self {
        case .jpg: return "jpg"
        case .png: return "png"
        }
    }

    func encode(_ image: UIImage) -> Data? {
        switch self {
        case .jpg(let quality):
            image.jpegData(compressionQuality: quality)
        case .png:
            image.pngData()
        }
    }
}

// MARK: - File storage

struct ImageFileStorage {

    private static let folder = "Images"
    private static let fileManager = FileManager.default

    @discardableResult
    static func save(
        _ image: UIImage,
        name: String,
        format: ImageStorageFormat = .jpg(quality: 0.9)
    ) -> String? {
        guard let dir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let folderURL = dir.appendingPathComponent(folder, isDirectory: true)
        try? fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)

        let fileURL = folderURL
            .appendingPathComponent(name)
            .appendingPathExtension(format.fileExtension)

        guard let data = format.encode(image) else { return nil }

        do {
            if fileManager.fileExists(atPath: fileURL.path) {
                try fileManager.removeItem(at: fileURL)
            }
           
            try data.write(to: fileURL, options: .atomic)
            return fileURL.path
        } catch {
            print("❌ Failed to save image:", error)
            return nil
        }
    }

    static func load(path: String?) -> UIImage? {
        guard let path, let data = fileManager.contents(atPath: path) else { return nil }
        return UIImage(data: data)
    }

    static func delete(path: String?) {
        guard let path else { return }
        try? fileManager.removeItem(atPath: path)
    }
}
