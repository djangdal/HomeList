//
//  AreaView.swift
//  HomeList
//
//  Created by David Jangdal on 2023-04-20.
//

import Foundation
import SwiftUI

struct AreaView: View {
    let area: Area

    @ViewBuilder var imageView: some View {
        AsyncImage(url: area.imageURL, content: { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        }, placeholder: {
            Color.black.opacity(0.4)
        })
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Area")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(top: 10, bottom: 0)
            Color.clear
            // This is a neat little hack to be able to scale image with fill without stretching other elements outside of screen
                .background(
                    imageView
                )
                .frame(height: 150)
                .clipped()

            Text(area.areaName)
                .foregroundColor(.black)
                .font(.title)
                .fontWeight(.bold)
                .padding(bottom: 1)

            Text("rating: \(area.rating)")
                .foregroundColor(.black.opacity(0.5))
                .font(.body)
                .padding(bottom: 1)


            Text("Average price: \(area.averagePrice) m\u{00B2}")
                .foregroundColor(.black.opacity(0.5))
                .font(.body)
                .padding(bottom: 1)
        }
        .padding(horizontal: 10)
        .background(Color.white)
        .cornerRadius(14)
    }
}

struct AreaView_Previews: PreviewProvider {
    static var previews: some View {
        AreaView(area: Area(id: "1234567892",
                            areaName: "Stockholm",
                            rating: "4.5/5",
                            averagePrice: 50100,
                            imageURL: URL(string: "https://i.imgur.com/v6GDnCG.png")!))
    }
}
