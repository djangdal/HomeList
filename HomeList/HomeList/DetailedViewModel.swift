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
    }
}

extension DetailedViewModel: DetailedViewModelProtocol {
}
