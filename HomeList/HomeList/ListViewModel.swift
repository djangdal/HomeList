//
//  ListViewModel.swift
//  HomeList
//
//  Created by David Jangdal on 2023-04-20.
//

import Foundation

protocol ListViewModelProtocol: ObservableObject {
    var properties: [PropertyType] { get }
    @Sendable func fetchProperties() async
}

final class ListViewModel {
    @Published var properties: [PropertyType] = []
    let apiService: APIPropertyServiceProtocol

    init(apiService: APIPropertyServiceProtocol) {
        self.apiService = apiService
        Task {
            await fetchProperties()
        }
    }
}

extension ListViewModel: ListViewModelProtocol {
    @MainActor func fetchProperties() async {
        do {
            self.properties = try await apiService.getListOfProperties().items.compactMap { item in
                if item.type == "HighlightedProperty" {
                    let property = try Property(apiItem: item)
                    return .highlitedProperty(property: property)
                }
                if item.type == "Property" {
                    let property = try Property(apiItem: item)
                    return .property(property: property)
                }
                if item.type == "Area" {
                    let area = try Area(apiItem: item)
                    return .area(area: area)
                }

                return nil
            }

            print("Props: \(self.properties)")
        } catch {
            print("Could not fetch properties: \(error)")
            // Here we could log somewhere and perhaps show some error to the user
        }
    }
}
