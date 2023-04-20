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
    let averagePrice: Int
    let imageURL: URL
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
                case .area(let area):
                    AreaView(area: area)
                }
            }
            Spacer()
        }
        .padding([.horizontal], 15)
        .background(Color.black.opacity(0.05))
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
                                             livingArea: 85)),
            .area(area: Area(id: "1234567892",
                             areaName: "Stockholm",
                             rating: "4.5/5",
                             averagePrice: 50100,
                             imageURL: URL(string: "https://i.imgur.com/v6GDnCG.png")!))
        ])
    }
}
