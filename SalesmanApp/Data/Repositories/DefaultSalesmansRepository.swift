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
    
    /** 
        Separate method for querying created in case we want to move logic for searching salesmen
        (e.g. to support paging) to Data layer (e.g. separate API method or Database querying)
     */
    func fetchSalesmans(query: SalesmanQuery) async -> Result<[Salesman], Error> {
        let data = SalesmanTestData.dtoData.map { $0.toDomain() }
        return .success(data)
    }
    
    func fetchSalesmans() async -> Result<[Salesman], Error> {
        let data = SalesmanTestData.dtoData.map { $0.toDomain() }
        return .success(data)
    }

}
