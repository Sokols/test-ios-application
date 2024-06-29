//
//  SalesmanAddressesViewModel.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import Foundation

protocol SalesmanAddressesViewModelInput {
    func viewDidLoad()
}

protocol SalesmanAddressesViewModelOutput: ObservableObject {
    var items: [Salesman] { get }
}

typealias SalesmanAddressesViewModel = SalesmanAddressesViewModelInput & SalesmanAddressesViewModelOutput

final class DefaultSalesmanAddressesViewModel: SalesmanAddressesViewModel {

    // MARK: - Output

    @Published var items: [Salesman] = []

    private let fetchSalesmansUseCase: FetchSalesmansUseCase

    // MARK: - Init

    init(fetchSalesmansUseCase: FetchSalesmansUseCase) {
        self.fetchSalesmansUseCase = fetchSalesmansUseCase
    }

}

// MARK: - Input implementation
extension DefaultSalesmanAddressesViewModel {
    func viewDidLoad() {
        #warning("TODO: Implement method")
    }
}
