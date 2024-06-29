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
        SalesmanDTO(name: "Artem Titarenko", areas: ["76133"]),
        SalesmanDTO(name: "Bernd Schmitt", areas: ["7619*"]),
        SalesmanDTO(name: "Chris Krapp", areas: ["762*"]),
        SalesmanDTO(name: "Alex Uber", areas: ["86*"])
    ]
}
