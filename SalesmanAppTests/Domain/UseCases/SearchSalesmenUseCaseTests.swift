//
//  SearchSalesmenUseCaseTests.swift
//  SalesmanAppTests
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import XCTest
@testable import SalesmanApp

final class SearchSalesmenUseCaseTests: XCTestCase {

    var mockSalesmansRepository: MockedSalesmansRepository!
    var useCase: DefaultSearchSalesmenUseCase!

    // MARK: - Set up

    override func setUp() {
        super.setUp()
        mockSalesmansRepository = MockedSalesmansRepository()
        useCase = DefaultSearchSalesmenUseCase(salesmansRepository: mockSalesmansRepository)
    }

    // MARK: - Tests

    func testSearchSalesmenUseCase_whenRepositoryReturnsFailure_thenUseCaseReturnsError() async throws {
        // given
        let dataSet = [
            SearchSalesmenUseCaseTests.oneFullAreaSalesman,
            SearchSalesmenUseCaseTests.justAsteriskAreaSalesman,
            SearchSalesmenUseCaseTests.noAreasSalesman
        ]
        mockSalesmansRepository.setDataSet(dataSet)
        mockSalesmansRepository.setResult(.failure(SalesmansRepositoryTestError.failedFetching))

        // when
        let searchText = "7"
        let result = await useCase.execute(searchText)

        // then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, SalesmansRepositoryTestError.failedFetching.localizedDescription)
        }
    }

    func testSearchSalesmenUseCase_whenThereIsNoSalesmen_thenUseCaseReturnsSuccessWithEmptyList() async throws {
        // given
        let dataSet: [Salesman] = []
        mockSalesmansRepository.setDataSet(dataSet)

        // when
        let searchText = "7"
        let result = await useCase.execute(searchText)

        // then
        let salesmen = try result.get()
        XCTAssertTrue(salesmen.isEmpty)
    }

    func testSearchSalesmenUseCase_whenSearchTextIsEmpty_thenAllSalesmenAreReturned() async throws {
        // given
        let dataSet = [
            SearchSalesmenUseCaseTests.oneFullAreaSalesman,
            SearchSalesmenUseCaseTests.justAsteriskAreaSalesman,
            SearchSalesmenUseCaseTests.noAreasSalesman
        ]
        mockSalesmansRepository.setDataSet(dataSet)

        // when
        let searchText = ""
        let result = await useCase.execute(searchText)

        // then
        let salesmen = Set(try result.get())
        XCTAssertTrue(salesmen == Set(dataSet))
    }

    func testSearchSalesmenUseCase_whenThereIsOneSalesmanWithNoAreasAndSearchTextIsPresent_thenThisSalesmanWithNoAresIsNotReturned() async throws {
        // given
        let dataSet = [
            SearchSalesmenUseCaseTests.oneFullAreaSalesman,
            SearchSalesmenUseCaseTests.justAsteriskAreaSalesman,
            SearchSalesmenUseCaseTests.noAreasSalesman
        ]
        mockSalesmansRepository.setDataSet(dataSet)

        // when
        let searchText = "7"
        let result = await useCase.execute(searchText)

        // then
        let salesmen = try result.get()
        XCTAssertFalse(salesmen.contains(where: { $0.id == SearchSalesmenUseCaseTests.noAreasSalesman.id }))
    }

    func testSearchSalesmenUseCase_whenThereIsSalesmanWithJustAsteriskAndSearchTextDoesNotMatchAnythingElse_thenOnlySalesmanWithAsteriskIsReturned() async throws {
        // given
        let dataSet = [
            SearchSalesmenUseCaseTests.oneFullAreaSalesman,
            SearchSalesmenUseCaseTests.justAsteriskAreaSalesman,
            SearchSalesmenUseCaseTests.noAreasSalesman
        ]
        mockSalesmansRepository.setDataSet(dataSet)

        // when
        let searchText = "1234"
        let result = await useCase.execute(searchText)

        // then
        let salesmen = try result.get()
        XCTAssertTrue(salesmen.count == 1)
        XCTAssertTrue(salesmen.contains(where: { $0.id == SearchSalesmenUseCaseTests.justAsteriskAreaSalesman.id }))
    }

    func testSearchSalesmenUseCase_whenSearchTextMatchesTwoSalesmenWithAsterisks_thenOnlyTheseSalesmenAreReturned() async throws {
        // given
        let dataSet = [
            SearchSalesmenUseCaseTests.oneFullAreaSalesman,
            SearchSalesmenUseCaseTests.oneAsteriskAreaSalesman,
            SearchSalesmenUseCaseTests.twoAsteriskAreasSalesman,
            SearchSalesmenUseCaseTests.noAreasSalesman
        ]
        mockSalesmansRepository.setDataSet(dataSet)

        // when
        let searchText = "7436"
        let result = await useCase.execute(searchText)

        // then
        let salesmen = try result.get()
        XCTAssertTrue(salesmen.count == 2)
        XCTAssertTrue(salesmen.contains(where: { $0.id == SearchSalesmenUseCaseTests.oneAsteriskAreaSalesman.id }))
        XCTAssertTrue(salesmen.contains(where: { $0.id == SearchSalesmenUseCaseTests.twoAsteriskAreasSalesman.id }))
    }

    func testSearchSalesmenUseCase_whenSearchTextPresentsFullPostalcodeThatMatchesTwoSalesmen_thenOnlyTheseSalesmenAreReturned() async throws {
        // given
        let dataSet = [
            SearchSalesmenUseCaseTests.oneFullAreaSalesman,
            SearchSalesmenUseCaseTests.oneAsteriskAreaSalesman,
            SearchSalesmenUseCaseTests.twoAsteriskAreasSalesman,
            SearchSalesmenUseCaseTests.noAreasSalesman
        ]
        mockSalesmansRepository.setDataSet(dataSet)

        // when
        let searchText = "76543"
        let result = await useCase.execute(searchText)

        // then
        let salesmen = try result.get()
        XCTAssertTrue(salesmen.count == 2)
        XCTAssertTrue(salesmen.contains(where: { $0.id == SearchSalesmenUseCaseTests.oneFullAreaSalesman.id }))
        XCTAssertTrue(salesmen.contains(where: { $0.id == SearchSalesmenUseCaseTests.twoAsteriskAreasSalesman.id }))
    }

    func testSearchSalesmenUseCase_whenSearchTextExceedsMaxDigits_thenEmptyListIsReturned() async throws {
        // given
        let dataSet = [
            SearchSalesmenUseCaseTests.oneAsteriskAreaSalesman,
            SearchSalesmenUseCaseTests.justAsteriskAreaSalesman,
            SearchSalesmenUseCaseTests.noAreasSalesman
        ]
        mockSalesmansRepository.setDataSet(dataSet)

        // when
        let searchText = "7654321"
        let result = await useCase.execute(searchText)

        // then
        let salesmen = try result.get()
        XCTAssertTrue(salesmen.count == 0)
    }    

    func testSearchSalesmenUseCase_whenSearchTextContainsCharacters_thenEmptyListIsReturned() async throws {
        // given
        let dataSet = [
            SearchSalesmenUseCaseTests.oneAsteriskAreaSalesman,
            SearchSalesmenUseCaseTests.justAsteriskAreaSalesman,
            SearchSalesmenUseCaseTests.noAreasSalesman
        ]
        mockSalesmansRepository.setDataSet(dataSet)

        // when
        let searchText = "7436a"
        let result = await useCase.execute(searchText)

        // then
        let salesmen = try result.get()
        XCTAssertTrue(salesmen.count == 0)
    }

    // MARK: - Mocks

    enum SalesmansRepositoryTestError: Error {
        case failedFetching
    }

    private static let oneFullAreaSalesman = Salesman(id: Salesman.Identifier(0), name: "Test0", areas: ["76543"])
    private static let oneAsteriskAreaSalesman = Salesman(id: Salesman.Identifier(1), name: "Test1", areas: ["743*"])
    private static let twoAsteriskAreasSalesman = Salesman(id: Salesman.Identifier(2), name: "Test2", areas: ["7436*", "7654*"])
    private static let noAreasSalesman = Salesman(id: Salesman.Identifier(3), name: "Test3", areas: [])
    private static let justAsteriskAreaSalesman = Salesman(id: Salesman.Identifier(4), name: "Test4", areas: ["*"])

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
    }
}
