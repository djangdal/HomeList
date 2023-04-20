//
//  HomeListApp.swift
//  HomeList
//
//  Created by David Jangdal on 2023-04-20.
//

import SwiftUI
import CosyNetwork

@main
struct HomeListApp: App {
    var body: some Scene {
        WindowGroup {
            let dispatcher = APIDispatcher(decoder: JSONDecoder())
            let apiPropertyService = APIPropertyService(dispatcher: dispatcher)
            let viewModel = ListViewModel(apiService: apiPropertyService)
            ListView(viewModel: viewModel)
        }
    }
}
