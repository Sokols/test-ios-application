//
//  Salesman.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import Foundation

struct Salesman: Identifiable {
    typealias Identifier = String

    let id: Identifier

    let name: String
    let areas: [String]
}
