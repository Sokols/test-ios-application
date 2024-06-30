//
//  SalesmanDTO.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import Foundation

struct SalesmanDTO: Decodable {
    let id: Int

    let name: String
    let areas: [String]
}

extension SalesmanDTO {
    func toDomain() -> Salesman {
        return .init(id: Salesman.Identifier(id),
                     name: name,
                     areas: areas)
    }
}
