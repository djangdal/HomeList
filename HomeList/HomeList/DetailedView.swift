//
//  DetailedView.swift
//  HomeList
//
//  Created by David Jangdal on 2023-04-20.
//

import SwiftUI

struct DetailedProperty {
    let id: String
    let imageURL: URL
    let address: String
    let municipality: String
    let price: Int
    let area: String
    let numberOfRooms: Int
    let livingArea: Int
    let description: String
    let patio: String
}

struct DetailedView: View {
    let property: DetailedProperty

    var body: some View {
        VStack(alignment: .leading) {
            RemoteImageView(url: property.imageURL)
                .frame(height: 200)
                .clipped()
                .padding(top: 10)

            Text(property.address)
                .foregroundColor(.black)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(bottom: 1)

            Text("\(property.area), \(property.municipality)")
                .foregroundColor(.black.opacity(0.5))
                .font(.body)
                .padding(bottom: 1)

            Text("\(property.price) SEK")
                .font(.title2)
                .fontWeight(.bold)

            Text(property.description)
                .font(.body)
                .padding(vertical: 20)

            VStack(alignment: .leading, spacing: 4) {
                Text("Living area: \(property.livingArea) m\u{00B2}")
                    .font(.body)
                    .fontWeight(.bold)

                Text("Number of rooms: \(property.numberOfRooms)")
                    .font(.body)
                    .fontWeight(.bold)

                Text("Patio: \(property.patio)")
                    .font(.body)
                    .fontWeight(.bold)

                Text("Days since publish: \(property.numberOfRooms)")
                    .font(.body)
                    .fontWeight(.bold)
            }

        }
        .padding(horizontal: 20)
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(property: DetailedProperty(id: "1",
                                                imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Hus_i_svarttorp.jpg/800px-Hus_i_svarttorp.jpg")!,
                                                address: "Mockvägen 1",
                                                municipality: "Gällivare kommun",
                                                price: 2650000,
                                                area: "Heden",
                                                numberOfRooms: 5,
                                                livingArea: 120,
                                                description: "The living room can be furnished according to your own wishes and tastes, here the whole family can gather and enjoy each other's company. From the living room you reach the terrace overlooking the lush courtyard which is located in undisturbed and secluded location.",
                                                patio: "Yes"))
    }
}
