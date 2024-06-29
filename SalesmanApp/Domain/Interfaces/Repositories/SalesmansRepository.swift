//
//  SalesmansRepository.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import Foundation

protocol SalesmansRepository {
    func fetchSalesmans() async -> Result<[Salesman], Error>
}
