//
//  ListViewModel.swift
//  HomeList
//
//  Created by David Jangdal on 2023-04-20.
//

import Foundation
import SwiftUI

protocol ListViewModelProtocol: ObservableObject {
    var properties: [PropertyType] { get }
    func didSelectFilter(_ value: Filter)
    func viewForProperty(_ property: Property) -> AnyView
}

final class ListViewModel {
    @Published var properties: [PropertyType] = []

    private var allProperties: [PropertyType] = []
    private var currentFilter: Filter = .all
    private let apiService: APIPropertyServiceProtocol

    init(apiService: APIPropertyServiceProtocol) {
        self.apiService = apiService
        Task {
            await fetchProperties()
        }
    }
}

private extension ListViewModel {
    @MainActor func fetchProperties() async {
        do {
            allProperties = try await apiService.getListOfProperties().items.compactMap { item in
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
            filterProperties()
        } catch {
            print("Could not fetch properties: \(error)")
            // Here we could log somewhere and perhaps show some error to the user
        }
    }

    func filterProperties() {
        properties = allProperties.filter { property in
            if currentFilter == .all { return true }
            switch property {
            case .area: return currentFilter == .area
            case .highlitedProperty: return currentFilter == .highlighted
            case .property: return currentFilter == .property
            }
        }
    }
}

extension ListViewModel: ListViewModelProtocol {
    func viewForProperty(_ property: Property) -> AnyView {
        let viewModel = DetailedViewModel(apiService: apiService, property: property)
        let view = DetailedView(viewModel: viewModel)
        return AnyView(view)
    }

    func didSelectFilter(_ value: Filter) {
        currentFilter = value
        filterProperties()
    }
}
