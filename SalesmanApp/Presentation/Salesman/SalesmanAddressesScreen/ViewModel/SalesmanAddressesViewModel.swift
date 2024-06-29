//
//  SalesmanAddressesViewModel.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import Foundation
import Combine

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

    private var disposeBag = Set<AnyCancellable>()
    private let fetchSalesmansUseCase: FetchSalesmansUseCase
    private let searchSalesmenUseCase: SearchSalesmenUseCase
    private let searchScheduler: DispatchQueue

    // MARK: - Init

    init(fetchSalesmansUseCase: FetchSalesmansUseCase,
         searchSalesmenUseCase: SearchSalesmenUseCase,
         searchScheduler: DispatchQueue) {
        self.fetchSalesmansUseCase = fetchSalesmansUseCase
        self.searchSalesmenUseCase = searchSalesmenUseCase
        self.searchScheduler = searchScheduler
        debounceSearchTextChanges()
    }

    // MARK: - Search

    private func debounceSearchTextChanges() {
        $searchText
            .debounce(for: 1, scheduler: searchScheduler)
            .sink { [weak self] text in
                await self?.filterSalesmans(with: text)
            }
            .store(in: &disposeBag)
    }

    // MARK: - Data operations

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

    @MainActor
    private func filterSalesmans(with searchText: String) async {
        let result = await searchSalesmenUseCase.execute(searchText)
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
