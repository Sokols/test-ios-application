//
//  SalesmanAddressesListView.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import SwiftUI

struct SalesmanAddressesListView<T: SalesmanAddressesViewModel>: View {
    @StateObject private var viewModel: T

    init(viewModel: T) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        #warning("TODO: Implement view")
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SalesmanAddressesListView_Previews: PreviewProvider {
    class MockViewModel: SalesmanAddressesViewModel {
        func viewDidLoad() {}
        var items: [Salesman] = []
    }

    private static var mockViewModel: MockViewModel = MockViewModel()

    static var previews: some View {
        SalesmanAddressesListView(viewModel: mockViewModel)
    }
}
