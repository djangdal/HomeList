//
//  ListView.swift
//  HomeList
//
//  Created by David Jangdal on 2023-04-20.
//

import SwiftUI

enum PropertyType: Identifiable {
    case property(property: Property)
    case highlitedProperty(property: Property)
    case area(area: Area)

    var id: String{
        switch self {
        case .area(let area): return area.id
        case .highlitedProperty(let property), .property(let property): return property.id
        }
    }
}

struct Property {
    let id: String
    let imageURL: URL
    let address: String
    let minicipality: String
    let price: Int
    let area: String
    let numberOfRooms: Int
    let livingArea: Int
}

struct Area {
    let id: String
    let areaName: String
    let rating: String
    let averagePrice: String
    let url: URL
}

struct ListView: View {
    let properties: [PropertyType]

    var body: some View {
        VStack {
            ForEach(properties) { property in
                switch property {
                case .highlitedProperty(let property):
                    PropertyView(property: property, isHighlighted: true)
                case .property(let property):
                    PropertyView(property: property, isHighlighted: false)
                case .area(let area): Text("")
                }
            }
            Spacer()
        }
        .padding([.horizontal], 15)
        .background(Color.black.opacity(0.05))
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
                Text("\(property.livingArea) m2")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(properties: [
            .highlitedProperty(property: Property(id: "1",
                                                  imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Hus_i_svarttorp.jpg/800px-Hus_i_svarttorp.jpg")!,
                                                  address: "Mockvägen 1",
                                                  minicipality: "Gällivare kommun",
                                                  price: 2650000,
                                                  area: "Heden",
                                                  numberOfRooms: 5,
                                                  livingArea: 120)),

                .property(property: Property(id: "2",
                                             imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/8/8f/Arkitekt_Peder_Magnussen_hus_H%C3%B8nefoss_HDR.jpg")!,
                                             address: "Mockvägen 2",
                                             minicipality: "Stockholm",
                                             price: 6950000,
                                             area: "Nedre Gärdet",
                                             numberOfRooms: 3,
                                             livingArea: 85))
        ])
    }
}
