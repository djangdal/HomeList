//
//  ImageDownloader.swift
//  HomeList
//
//  Created by David Jangdal on 2023-04-20.
//

import Foundation
import UIKit

enum ImageDownloadError: Error {
    case statusCodeNotOK
    case couldNotCreateImageFromData
}

@globalActor actor ImageDownloader {
    static let shared: ImageDownloader = ImageDownloader()

    private var cache: [URL: UIImage] = [:]

    func downloadImage(from url: URL) async throws -> UIImage {
        if let image = cache[url] {
            return image
        }
        let response = try await URLSession.shared.data(from: url)

        guard let httpResponse = response.1 as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ImageDownloadError.statusCodeNotOK
        }

        guard let image = UIImage(data: response.0) else {
            throw ImageDownloadError.couldNotCreateImageFromData
        }
        cache[url] = image
        return image
    }
}
