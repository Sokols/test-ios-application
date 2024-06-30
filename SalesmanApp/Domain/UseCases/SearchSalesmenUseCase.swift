//
//  SearchSalesmenUseCase.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import Foundation

protocol SearchSalesmenUseCase {
    func execute(_ searchText: String) async -> Result<[Salesman], Error>
}

final class DefaultSearchSalesmenUseCase {

    private let salesmenRepository: SalesmenRepository

    init(salesmenRepository: SalesmenRepository) {
        self.salesmenRepository = salesmenRepository
    }
}

extension DefaultSearchSalesmenUseCase: SearchSalesmenUseCase {
    func execute(_ searchText: String) async -> Result<[Salesman], Error> {
        let query = SalesmanQuery(query: searchText)
        let result = await salesmenRepository.fetchSalesmen(query: query)
        switch result {
        case .success(let salesmen):
            /** 
                Filtering applied in the Domain layer, but can be easily moved to the Data layer by using
                the separate repository method.
             */
            let filteredResult = salesmen.filter(with: searchText)
            return .success(filteredResult)
        case .failure(let failure):
            return .failure(failure)
        }
    }
}
