//
//  RemoteImageView.swift
//  HomeList
//
//  Created by David Jangdal on 2023-04-20.
//

import Foundation
import SwiftUI

struct RemoteImageView: View {
    let url: URL?
    @State var image: UIImage? = nil

    var body: some View {
        Group {
            if let image = image {
                // This is a neat little hack to be able to scale image with fill without stretching other elements outside of screen
                Color.clear
                    .background(
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    )
            } else {
                Color.black.opacity(0.2)
            }
        }
        .onAppear {
            Task {
                guard let url = url else { return }
                self.image = try? await ImageDownloader.shared.downloadImage(from: url)
            }
        }
    }
}
