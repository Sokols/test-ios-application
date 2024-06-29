//
//  FetchSalesmansUseCase.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import Foundation

protocol FetchSalesmansUseCase {
    func execute() async -> Result<[Salesman], Error>
}

final class DefaultFetchSalesmansUseCase {

    private let salesmansRepository: SalesmansRepository

    init(salesmansRepository: SalesmansRepository) {
        self.salesmansRepository = salesmansRepository
    }
}

extension DefaultFetchSalesmansUseCase: FetchSalesmansUseCase {
    func execute() async -> Result<[Salesman], Error> {
        return await salesmansRepository.fetchSalesmans()
    }
}
