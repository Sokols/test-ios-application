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
            MockedSalesmansRepository.oneFullAreaSalesman,
            MockedSalesmansRepository.justAsteriskAreaSalesman,
            MockedSalesmansRepository.noAreasSalesman
        ]
        mockSalesmansRepository.setDataSet(dataSet)
        mockSalesmansRepository.setResult(.failure(MockedSalesmansRepository.SalesmansRepositoryTestError.failedFetching))

        // when
        let searchText = "7"
        let result = await useCase.execute(searchText)

        // then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, MockedSalesmansRepository.SalesmansRepositoryTestError.failedFetching.localizedDescription)
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
            MockedSalesmansRepository.oneFullAreaSalesman,
            MockedSalesmansRepository.justAsteriskAreaSalesman,
            MockedSalesmansRepository.noAreasSalesman
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
            MockedSalesmansRepository.oneFullAreaSalesman,
            MockedSalesmansRepository.justAsteriskAreaSalesman,
            MockedSalesmansRepository.noAreasSalesman
        ]
        mockSalesmansRepository.setDataSet(dataSet)

        // when
        let searchText = "7"
        let result = await useCase.execute(searchText)

        // then
        let salesmen = try result.get()
        XCTAssertFalse(salesmen.contains(where: { $0.id == MockedSalesmansRepository.noAreasSalesman.id }))
    }

    func testSearchSalesmenUseCase_whenThereIsSalesmanWithJustAsteriskAndSearchTextDoesNotMatchAnythingElse_thenOnlySalesmanWithAsteriskIsReturned() async throws {
        // given
        let dataSet = [
            MockedSalesmansRepository.oneFullAreaSalesman,
            MockedSalesmansRepository.justAsteriskAreaSalesman,
            MockedSalesmansRepository.noAreasSalesman
        ]
        mockSalesmansRepository.setDataSet(dataSet)

        // when
        let searchText = "1234"
        let result = await useCase.execute(searchText)

        // then
        let salesmen = try result.get()
        XCTAssertTrue(salesmen.count == 1)
        XCTAssertTrue(salesmen.contains(where: { $0.id == MockedSalesmansRepository.justAsteriskAreaSalesman.id }))
    }

    func testSearchSalesmenUseCase_whenSearchTextMatchesTwoSalesmenWithAsterisks_thenOnlyTheseSalesmenAreReturned() async throws {
        // given
        let dataSet = [
            MockedSalesmansRepository.oneFullAreaSalesman,
            MockedSalesmansRepository.oneAsteriskAreaSalesman,
            MockedSalesmansRepository.twoAsteriskAreasSalesman,
            MockedSalesmansRepository.noAreasSalesman
        ]
        mockSalesmansRepository.setDataSet(dataSet)

        // when
        let searchText = "7436"
        let result = await useCase.execute(searchText)

        // then
        let salesmen = try result.get()
        XCTAssertTrue(salesmen.count == 2)
        XCTAssertTrue(salesmen.contains(where: { $0.id == MockedSalesmansRepository.oneAsteriskAreaSalesman.id }))
        XCTAssertTrue(salesmen.contains(where: { $0.id == MockedSalesmansRepository.twoAsteriskAreasSalesman.id }))
    }

    func testSearchSalesmenUseCase_whenSearchTextPresentsFullPostalcodeThatMatchesTwoSalesmen_thenOnlyTheseSalesmenAreReturned() async throws {
        // given
        let dataSet = [
            MockedSalesmansRepository.oneFullAreaSalesman,
            MockedSalesmansRepository.oneAsteriskAreaSalesman,
            MockedSalesmansRepository.twoAsteriskAreasSalesman,
            MockedSalesmansRepository.noAreasSalesman
        ]
        mockSalesmansRepository.setDataSet(dataSet)

        // when
        let searchText = "76543"
        let result = await useCase.execute(searchText)

        // then
        let salesmen = try result.get()
        XCTAssertTrue(salesmen.count == 2)
        XCTAssertTrue(salesmen.contains(where: { $0.id == MockedSalesmansRepository.oneFullAreaSalesman.id }))
        XCTAssertTrue(salesmen.contains(where: { $0.id == MockedSalesmansRepository.twoAsteriskAreasSalesman.id }))
    }

    func testSearchSalesmenUseCase_whenSearchTextExceedsMaxDigits_thenEmptyListIsReturned() async throws {
        // given
        let dataSet = [
            MockedSalesmansRepository.oneAsteriskAreaSalesman,
            MockedSalesmansRepository.justAsteriskAreaSalesman,
            MockedSalesmansRepository.noAreasSalesman
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
            MockedSalesmansRepository.oneAsteriskAreaSalesman,
            MockedSalesmansRepository.justAsteriskAreaSalesman,
            MockedSalesmansRepository.noAreasSalesman
        ]
        mockSalesmansRepository.setDataSet(dataSet)

        // when
        let searchText = "7436a"
        let result = await useCase.execute(searchText)

        // then
        let salesmen = try result.get()
        XCTAssertTrue(salesmen.count == 0)
    }
}
