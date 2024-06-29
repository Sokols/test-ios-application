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
        DefaultSalesmanAddressesViewModel(fetchSalesmansUseCase: makeFetchSalesmansUseCase(),
                                          searchSalesmenUseCase: makeSearchSalesmenUseCase(),
                                          searchScheduler: makeSearchScheduler()) as! T
    }

    // MARK: - DispatchQueue

    private func makeSearchScheduler() -> DispatchQueue {
        DispatchQueue(label: "SalesmanAddressesSearchScheduler", qos: .userInteractive)
    }

    // MARK: - UseCase

    private func makeFetchSalesmansUseCase() -> FetchSalesmansUseCase {
        DefaultFetchSalesmansUseCase(salesmansRepository: makeSalesmansRepository())
    }

    private func makeSearchSalesmenUseCase() -> SearchSalesmenUseCase {
        DefaultSearchSalesmenUseCase(salesmansRepository: makeSalesmansRepository())
    }

    // MARK: - Repository

    private func makeSalesmansRepository() -> SalesmansRepository {
        DefaultSalesmansRepository()
    }

}
