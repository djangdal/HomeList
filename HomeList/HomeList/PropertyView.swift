//
//  PropertyView.swift
//  HomeList
//
//  Created by David Jangdal on 2023-04-20.
//

import Foundation
import SwiftUI

struct PropertyView: View {
    let property: Property
    let isHighlighted: Bool

    @ViewBuilder var imageView: some View {
        AsyncImage(url: property.imageURL, content: { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        }, placeholder: {
            Color.black.opacity(0.4)
        })
    }

    var body: some View {
        VStack(alignment: .leading) {
            Color.clear
            // This is a neat little hack to be able to scale image with fill without stretching other elements outside of screen
                .background(
                    imageView
                )
                .frame(height: 150)
                .styleForHighlighted(highlighted: isHighlighted)
                .clipped()
                .padding(top: 10)

            Text(property.address)
                .foregroundColor(.black)
                .font(.title)
                .fontWeight(.bold)
                .padding(bottom: 1)

            Text("\(property.area), \(property.minicipality)")
                .foregroundColor(.black.opacity(0.5))
                .font(.body)
                .padding(bottom: 1)

            HStack {
                Text("\(property.price) SEK")
                    .font(.body)
                    .fontWeight(.bold)
                Spacer()
                Text("\(property.livingArea) m\u{00B2}")
                    .font(.body)
                    .fontWeight(.bold)
                Spacer()
                Text("\(property.numberOfRooms) rooms")
                    .font(.body)
                    .fontWeight(.bold)
            }
            .padding(bottom: 10)
        }
        .padding(horizontal: 10)
        .background(Color.white)
        .cornerRadius(14)
    }
}

private extension View {
    @ViewBuilder func styleForHighlighted(highlighted: Bool) -> some View {
        if highlighted {
            self.border(Color(red: 255, green: 215, blue: 0), width: 3) // This can be moved to a design system
        } else {
            self
        }
    }
}

struct PropertyView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyView(property: Property(id: "1",
                                        imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Hus_i_svarttorp.jpg/800px-Hus_i_svarttorp.jpg")!,
                                        address: "Mockvägen 1",
                                        minicipality: "Gällivare kommun",
                                        price: 2650000,
                                        area: "Heden",
                                        numberOfRooms: 5,
                                        livingArea: 120),
                     isHighlighted: true)
        .previewDisplayName("highlighted")

        PropertyView(property: Property(id: "2",
                                        imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/8/8f/Arkitekt_Peder_Magnussen_hus_H%C3%B8nefoss_HDR.jpg")!,
                                        address: "Mockvägen 2",
                                        minicipality: "Stockholm",
                                        price: 6950000,
                                        area: "Nedre Gärdet",
                                        numberOfRooms: 3,
                                        livingArea: 85),
                     isHighlighted: false)
        .previewDisplayName("not highlighted")
    }
}
