//
//  SalesmanAddressesListView.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import SwiftUI

struct SalesmanAddressesListView<T: SalesmanAddressesViewModel>: View {
    @StateObject private var viewModel: T
    @State private var searchText: String = ""

    init(viewModel: T) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            TopNavBar(title: "Addresses") {
                #warning("TODO: Implement navigation")
            }
            SearchBar(text: $searchText)
            List {
                ForEach(viewModel.items) { item in
                    SalesmanRow(item: item)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(PlainListStyle())
        }
        .applySafeAreaTopColor()
        .navigationBarBackButtonHidden()
    }
}

struct SalesmanAddressesListView_Previews: PreviewProvider {
    class MockViewModel: SalesmanAddressesViewModel {
        func viewDidLoad() {}
        var items: [Salesman] = SalesmanTestData.data
    }

    private static var mockViewModel: MockViewModel = MockViewModel()

    static var previews: some View {
        SalesmanAddressesListView(viewModel: mockViewModel)
    }
}
