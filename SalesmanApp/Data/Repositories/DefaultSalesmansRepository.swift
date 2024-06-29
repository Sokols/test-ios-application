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
        let data = DefaultSalesmansRepository.data.map { $0.toDomain() }
        return .success(data)
    }

    private static var data = [
        SalesmanDTO(name: "Artem Titarenko", areas: ["76133"]),
        SalesmanDTO(name: "Bernd Schmitt", areas: ["7619*"]),
        SalesmanDTO(name: "Chris Krapp", areas: ["762*"]),
        SalesmanDTO(name: "Alex Uber", areas: ["86*"])
    ]
}
