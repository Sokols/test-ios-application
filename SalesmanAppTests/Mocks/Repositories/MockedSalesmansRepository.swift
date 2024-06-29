//
//  MockedSalesmansRepository.swift
//  SalesmanAppTests
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

@testable import SalesmanApp

final class MockedSalesmansRepository: SalesmansRepository {

    private(set) var dataSet: [Salesman] = []
    private(set) var result: Result<[Salesman], Error>? = nil

    // MARK: - Setup

    func setResult(_ result: Result<[Salesman], Error>) {
        self.result = result
    }

    func setDataSet(_ dataSet: [Salesman]) {
        self.dataSet = dataSet
    }

    // MARK: - Overridden

    func fetchSalesmans(query: SalesmanQuery) async -> Result<[Salesman], Error> {
        return result ?? .success(dataSet)
    }

    func fetchSalesmans() async -> Result<[Salesman], Error> {
        return result ?? .success(dataSet)
    }

    // MARK: - Mocks

    enum SalesmansRepositoryTestError: Error {
        case failedFetching
    }

    static let oneFullAreaSalesman = Salesman(id: Salesman.Identifier(0), name: "Test0", areas: ["76543"])
    static let oneAsteriskAreaSalesman = Salesman(id: Salesman.Identifier(1), name: "Test1", areas: ["743*"])
    static let twoAsteriskAreasSalesman = Salesman(id: Salesman.Identifier(2), name: "Test2", areas: ["7436*", "7654*"])
    static let noAreasSalesman = Salesman(id: Salesman.Identifier(3), name: "Test3", areas: [])
    static let justAsteriskAreaSalesman = Salesman(id: Salesman.Identifier(4), name: "Test4", areas: ["*"])
}
