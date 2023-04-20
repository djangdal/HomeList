//
//  APIPropertyService.swift
//  HomeList
//
//  Created by David Jangdal on 2023-04-20.
//

import Foundation
import CosyNetwork

let baseURL = "https://pastebin.com" // This could later be fetched from something else to go to a stage env etc.

protocol APIPropertyServiceProtocol: AnyObject {
    func getListOfProperties() async throws -> PropertiesResponse
}

actor APIPropertyService: APIPropertyServiceProtocol {
    private let dispatcher: APIDispatcher

    init(dispatcher: APIDispatcher) {
        self.dispatcher = dispatcher
    }

    func getListOfProperties() async throws -> PropertiesResponse {
        let request = PropertiesRequest()
        let response = try await dispatcher.dispatch(request)
        return response.0
    }
}

fileprivate struct PropertiesRequest: APIDecodableRequest {
    typealias ResponseBodyType = PropertiesResponse
    typealias ErrorBodyType = PropertiesError

    var baseURLPath: String = baseURL
    var path: String = "/raw/nH5NinBi"

    var method: CosyNetwork.HTTPMethod = .get
    var successStatusCodes: [CosyNetwork.HTTPStatusCode] = [.ok]
    var failingStatusCodes: [CosyNetwork.HTTPStatusCode] = [.badRequest]
    var requestHeaders: [String : String]?
}

struct PropertiesError: Error, Decodable {
    // Here we can parse error values sent from backend
}

struct PropertiesResponse: Decodable {
    let items: [Item]

    struct Item: Decodable {
        let type: String
        let id: String
        let area: String
        let askingPrice: Int?
        let monthlyFee: Int?
        let municipality: String?
        let daysSincePublish: Int?
        let ratingFormatted: String?
        let livingArea: Int?
        let numberOfRooms: Int?
        let streetAddress: String?
        let description: String?
        let image: URL
    }
}
