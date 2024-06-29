//
//  SalesmanDIContainer.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import SwiftUI

struct SalesmanDIContainer {

    // MARK: - View

    func makeSalesmanAddresssesListView() -> some View {
        let viewModel: DefaultSalesmanAddressesViewModel = makeSalesmanAddressesViewModel()
        return SalesmanAddressesListView(viewModel: viewModel)
    }

    // MARK: - ViewModel

    private func makeSalesmanAddressesViewModel<T: SalesmanAddressesViewModel>() -> T {
        DefaultSalesmanAddressesViewModel(fetchSalesmenUseCase: makeFetchSalesmenUseCase(),
                                          searchSalesmenUseCase: makeSearchSalesmenUseCase(),
                                          searchScheduler: makeSearchScheduler()) as! T
    }

    // MARK: - DispatchQueue

    private func makeSearchScheduler() -> DispatchQueue {
        DispatchQueue(label: "SalesmanAddressesSearchScheduler", qos: .userInteractive)
    }

    // MARK: - UseCase

    private func makeFetchSalesmenUseCase() -> FetchSalesmenUseCase {
        DefaultFetchSalesmenUseCase(salesmenRepository: makeSalesmenRepository())
    }

    private func makeSearchSalesmenUseCase() -> SearchSalesmenUseCase {
        DefaultSearchSalesmenUseCase(salesmenRepository: makeSalesmenRepository())
    }

    // MARK: - Repository

    private func makeSalesmenRepository() -> SalesmenRepository {
        DefaultSalesmenRepository()
    }

}
