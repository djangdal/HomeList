//
//  DetailedProperty.swift
//  HomeList
//
//  Created by David Jangdal on 2023-04-20.
//

import Foundation

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

    init(apiResponse: DetailedResponse) {
        self.id = apiResponse.id
        self.imageURL = apiResponse.image
        self.address = apiResponse.streetAddress
        self.municipality = apiResponse.municipality
        self.price = apiResponse.askingPrice
        self.area = apiResponse.area
        self.numberOfRooms = apiResponse.numberOfRooms
        self.livingArea = apiResponse.livingArea
        self.description = apiResponse.description
        self.patio = apiResponse.patio
    }
}
