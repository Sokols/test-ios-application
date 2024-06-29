//
//  DefaultSalesmansRepository.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import Foundation

final class DefaultSalesmansRepository {

    #warning("TODO: Initialize repository with DataSource")
}

extension DefaultSalesmansRepository: SalesmansRepository {

    #warning("TODO: Replace MOCK with Realm Database implementation")
    func fetchSalesmans() async -> Result<[Salesman], Error> {
        let data = SalesmanTestData.dtoData.map { $0.toDomain() }
        return .success(data)
    }
}
