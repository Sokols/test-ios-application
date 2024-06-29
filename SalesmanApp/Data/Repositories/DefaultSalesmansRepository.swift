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
    func fetchSalesmans() async -> Result<[Salesman], Error> {
        #warning("TODO: Implement fetching Salesmans")
        return .success([])
    }
}
