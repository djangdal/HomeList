//
//  DetailedViewModel.swift
//  HomeList
//
//  Created by David Jangdal on 2023-04-20.
//

import Foundation

import Foundation
import SwiftUI

protocol DetailedViewModelProtocol: ObservableObject {
    var property: DetailedProperty { get }
}

final class DetailedViewModel {
    @Published var property: DetailedProperty
    let apiService: APIPropertyServiceProtocol

    init(apiService: APIPropertyServiceProtocol, property: Property) {
        self.apiService = apiService
        self.property = DetailedProperty(property: property)
        Task {
            await fetchDetailedInfo()
        }
    }
}

private extension DetailedViewModel {
    @MainActor func fetchDetailedInfo() async {
        do {
            let detailedResponse = try await apiService.getDetailedInfo()
            self.property = DetailedProperty(apiResponse: detailedResponse)
        } catch {
            print("Could not fetch properties: \(error)")
            // Here we could log somewhere and perhaps show some error to the user
        }
    }
}

extension DetailedViewModel: DetailedViewModelProtocol {
}
