//
//  SalesmansRepository.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import Foundation

protocol SalesmansRepository {
    func fetchSalesmans(query: SalesmanQuery) async -> Result<[Salesman], Error>
    func fetchSalesmans() async -> Result<[Salesman], Error>
}
