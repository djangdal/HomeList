//
//  HomeListTests.swift
//  HomeListTests
//
//  Created by David Jangdal on 2023-04-20.
//

import XCTest
@testable import HomeList

final class HomeListTests: XCTestCase {

    func testCreateProperty_hasCorrectValues() throws{
        let item = PropertiesResponse.Item(type: "Value 1",
                                           id: "Value 2",
                                           area: "Value 3",
                                           askingPrice: 1,
                                           averagePrice: 2,
                                           monthlyFee: 3,
                                           municipality: "Value 4",
                                           daysSincePublish: 4,
                                           ratingFormatted: "Value 5",
                                           livingArea: 5,
                                           numberOfRooms: 6,
                                           streetAddress: "Value 6",
                                           description: "Value 7",
                                           image: URL(string: "http://example.com")!)
        let property = try Property(apiItem: item)
        XCTAssertEqual(property.id, "Value 2")
        XCTAssertEqual(property.imageURL, URL(string: "http://example.com")!)
        XCTAssertEqual(property.address, "Value 6")
        XCTAssertEqual(property.municipality, "Value 4")
        XCTAssertEqual(property.price, 1)
        XCTAssertEqual(property.area, "Value 3")
        XCTAssertEqual(property.numberOfRooms, 6)
        XCTAssertEqual(property.livingArea, 5)
    }

    func testCreateArea_hasCorrectValues() throws{
        let item = PropertiesResponse.Item(type: "Value 1",
                                           id: "Value 2",
                                           area: "Value 3",
                                           askingPrice: 1,
                                           averagePrice: 2,
                                           monthlyFee: 3,
                                           municipality: "Value 4",
                                           daysSincePublish: 4,
                                           ratingFormatted: "Value 5",
                                           livingArea: 5,
                                           numberOfRooms: 6,
                                           streetAddress: "Value 6",
                                           description: "Value 7",
                                           image: URL(string: "http://example.com")!)
        let area = try Area(apiItem: item)
        XCTAssertEqual(area.id, "Value 2")
        XCTAssertEqual(area.areaName, "Value 3")
        XCTAssertEqual(area.rating, "Value 5")
        XCTAssertEqual(area.averagePrice, 2)
        XCTAssertEqual(area.imageURL, URL(string: "http://example.com")!)
    }
}
