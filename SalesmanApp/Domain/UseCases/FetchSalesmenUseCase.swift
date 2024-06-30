//
//  FetchSalesmenUseCase.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import Foundation

protocol FetchSalesmenUseCase {
    func execute() async -> Result<[Salesman], Error>
}

final class DefaultFetchSalesmenUseCase {

    private let salesmenRepository: SalesmenRepository

    init(salesmenRepository: SalesmenRepository) {
        self.salesmenRepository = salesmenRepository
    }
}

extension DefaultFetchSalesmenUseCase: FetchSalesmenUseCase {
    func execute() async -> Result<[Salesman], Error> {
        return await salesmenRepository.fetchSalesmen()
    }
}
