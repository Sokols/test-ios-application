//
//  SalesmenRepository.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import Foundation

protocol SalesmenRepository {
    func fetchSalesmen(query: SalesmanQuery) async -> Result<[Salesman], Error>
    func fetchSalesmen() async -> Result<[Salesman], Error>
}
