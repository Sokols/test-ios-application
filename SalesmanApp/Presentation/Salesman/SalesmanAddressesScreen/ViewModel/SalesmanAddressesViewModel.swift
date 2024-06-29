//
//  SalesmanAddressesViewModel.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import Foundation

enum SalesmanAddressesViewModelState {
    case idle
    case loading
    case failed(Error)
    case loaded([Salesman])
}

protocol SalesmanAddressesViewModelInput {
    func loadData() async
}

protocol SalesmanAddressesViewModelOutput: ObservableObject {
    var state: SalesmanAddressesViewModelState { get }
    var searchText: String { get set }
}

typealias SalesmanAddressesViewModel = SalesmanAddressesViewModelInput & SalesmanAddressesViewModelOutput

final class DefaultSalesmanAddressesViewModel: SalesmanAddressesViewModel {

    // MARK: - Output

    @Published private(set) var state = SalesmanAddressesViewModelState.idle
    @Published var searchText: String = ""

    private let fetchSalesmansUseCase: FetchSalesmansUseCase

    // MARK: - Init

    init(fetchSalesmansUseCase: FetchSalesmansUseCase) {
        self.fetchSalesmansUseCase = fetchSalesmansUseCase
    }

    // MARK: - Fetch data

    @MainActor
    private func fetchSalesmans() async {
        state = .loading
        let result = await fetchSalesmansUseCase.execute()
        switch result {
        case .success(let items):
            state = .loaded(items)
        case .failure(let error):
            state = .failed(error)
        }
    }

}

// MARK: - Input implementation
extension DefaultSalesmanAddressesViewModel {
    func loadData() async {
        await fetchSalesmans()
    }
}
