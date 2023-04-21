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

enum Filter: String, CaseIterable {
    case all
    case highlighted
    case property
    case area
}

struct ListView<ViewModel: ListViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    @State var selectedProperty: Property?
    @State private var filter: Filter = .all
    private let filterOptions: [Filter] = Filter.allCases

    var header: some View {
        VStack {
            Spacer()
            HStack(alignment: .bottom) {
                Text("HomeList: \(viewModel.properties.count) listings")
                Spacer()
                Picker("Type", selection: $filter) {
                    ForEach(filterOptions, id: \.self) {
                        Text("\($0.rawValue.capitalized)")
                    }
                }
                .pickerStyle(.menu)
            }
            .padding(horizontal: 20)
            .padding(bottom: 10)
        }
        .frame(height: 120)
        .background(Color(red: 228/255, green: 232/255, blue: 218/255))
    }

    var body: some View {
        VStack(spacing: 0) {
            header
            ScrollView {
                ForEach(viewModel.properties) { property in
                    switch property {
                    case .highlitedProperty(let property):
                        Button {
                            selectedProperty = property
                        } label: {
                            PropertyView(property: property, isHighlighted: true)
                        }
                    case .property(let property):
                        PropertyView(property: property, isHighlighted: false)
                    case .area(let area):
                        AreaView(area: area)
                    }
                }
                .padding(top: 10)
            }
            .padding(horizontal: 15)
        }
        .edgesIgnoringSafeArea(.top)
        .sheet(item: $selectedProperty, content: { property in
            viewModel.viewForProperty(property)
        })
        .onChange(of: filter, perform: { value in
            viewModel.didSelectFilter(value)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: EmptyViewModel())
            .previewDisplayName("empty")
        ListView(viewModel: MockViewModel())
            .previewDisplayName("filled")
    }
}

private final class EmptyViewModel: ListViewModelProtocol {
    let properties: [PropertyType] = []
    func didSelectFilter(_ value: Filter) {}
    func viewForProperty(_ property: Property) -> AnyView {AnyView(Text(""))}
}

private final class MockViewModel: ListViewModelProtocol {
    let properties: [PropertyType] = [
        .highlitedProperty(property: Property(id: "1",
                                              imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Hus_i_svarttorp.jpg/800px-Hus_i_svarttorp.jpg")!,
                                              address: "Mockvägen 1",
                                              municipality: "Gällivare kommun",
                                              price: 2650000,
                                              area: "Heden",
                                              numberOfRooms: 5,
                                              livingArea: 120)),
        
            .property(property: Property(id: "2",
                                         imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/8/8f/Arkitekt_Peder_Magnussen_hus_H%C3%B8nefoss_HDR.jpg")!,
                                         address: "Mockvägen 2",
                                         municipality: "Stockholm",
                                         price: 6950000,
                                         area: "Nedre Gärdet",
                                         numberOfRooms: 3,
                                         livingArea: 85)),
        .area(area: Area(id: "1234567892",
                         areaName: "Stockholm",
                         rating: "4.5/5",
                         averagePrice: 50100,
                         imageURL: URL(string: "https://i.imgur.com/v6GDnCG.png")!))
    ]

    func didSelectFilter(_ value: Filter) {}
    func viewForProperty(_ property: Property) -> AnyView {AnyView(Text(""))}
}

