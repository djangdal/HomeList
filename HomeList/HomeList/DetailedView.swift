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
    let description: String?
    let patio: String?
}

extension DetailedProperty {
    init(property: Property) {
        id = property.id
        imageURL = property.imageURL
        address = property.address
        municipality = property.municipality
        price = property.price
        area = property.area
        numberOfRooms = property.numberOfRooms
        livingArea = property.livingArea
        description = nil
        patio = nil
    }
}

struct DetailedView<ViewModel: DetailedViewModelProtocol>: View {
    let viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading) {
            RemoteImageView(url: viewModel.property.imageURL)
                .frame(height: 200)
                .clipped()
                .padding(top: 10)

            Text(viewModel.property.address)
                .foregroundColor(.black)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(bottom: 1)

            Text("\(viewModel.property.area), \(viewModel.property.municipality)")
                .foregroundColor(.black.opacity(0.5))
                .font(.body)
                .padding(bottom: 1)

            Text("\(viewModel.property.price) SEK")
                .font(.title2)
                .fontWeight(.bold)

            if let description = viewModel.property.description {
                Text(description)
                    .font(.body)
                    .padding(vertical: 20)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Living area: \(viewModel.property.livingArea) m\u{00B2}")
                    .font(.body)
                    .fontWeight(.bold)

                Text("Number of rooms: \(viewModel.property.numberOfRooms)")
                    .font(.body)
                    .fontWeight(.bold)

                if let patio = viewModel.property.patio {
                    Text("Patio: \(patio)")
                        .font(.body)
                        .fontWeight(.bold)
                }

                Text("Days since publish: \(viewModel.property.numberOfRooms)")
                    .font(.body)
                    .fontWeight(.bold)
            }

        }
        .padding(horizontal: 20)
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(viewModel: MockViewModel())
    }
}

private final class MockViewModel: DetailedViewModelProtocol {
    var property = DetailedProperty(id: "1",
                                            imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Hus_i_svarttorp.jpg/800px-Hus_i_svarttorp.jpg")!,
                                            address: "Mockvägen 1",
                                            municipality: "Gällivare kommun",
                                            price: 2650000,
                                            area: "Heden",
                                            numberOfRooms: 5,
                                            livingArea: 120,
                                            description: "The living room can be furnished according to your own wishes and tastes, here the whole family can gather and enjoy each other's company. From the living room you reach the terrace overlooking the lush courtyard which is located in undisturbed and secluded location.",
                                            patio: "Yes")
}
