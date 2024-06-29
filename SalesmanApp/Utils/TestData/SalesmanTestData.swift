//
//  SalesmanTestData.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import Foundation

struct SalesmanTestData {

    static var data = dtoData.map { $0.toDomain() }

    static var dtoData = [
        SalesmanDTO(id: 0, name: "Artem Titarenko", areas: ["76133"]),
        SalesmanDTO(id: 1, name: "Bernd Schmitt", areas: ["7619*"]),
        SalesmanDTO(id: 2, name: "Chris Krapp", areas: ["762*"]),
        SalesmanDTO(id: 3, name: "Alex Uber", areas: ["86*"])
    ]
}
