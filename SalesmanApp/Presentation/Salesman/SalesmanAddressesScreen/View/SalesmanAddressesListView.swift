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
        VStack {
            TopNavBar(title: "Addresses") {
                #warning("TODO: Implement navigation")
            }
            SearchBar(text: $viewModel.searchText)
            contentView
        }
        .task {
            await viewModel.loadData()
        }
        .applySafeAreaTopColor(.navBarBackground)
        .navigationBarBackButtonHidden()
    }

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .loading:
            progressView
        case .loaded(let items):
            listView(items)
        case .failed(let error):
            errorView(error)
        default:
            EmptyView()
        }
    }

    @ViewBuilder
    private var progressView: some View {
        Spacer()
        ProgressView()
        Spacer()
    }

    @ViewBuilder
    private func listView(_ items: [Salesman]) -> some View {
        List {
            ForEach(items) { item in
                SalesmanRow(item: item)
            }
            .listRowInsets(EdgeInsets())
        }
        .listStyle(PlainListStyle())
    }

    @ViewBuilder
    private func errorView(_ error: Error) -> some View {
        Spacer()
        Text(error.localizedDescription)
        Spacer()
    }
}

struct SalesmanAddressesListView_Previews: PreviewProvider {
    final class MockViewModel: SalesmanAddressesViewModel {
        var searchText: String = ""
        var state: SalesmanAddressesViewModelState = .loaded(SalesmanTestData.data)

        func loadData() async {}
    }

    private static var mockViewModel: MockViewModel = MockViewModel()

    static var previews: some View {
        SalesmanAddressesListView(viewModel: mockViewModel)
    }
}
