//
//  SearchSalesmenUseCaseTests.swift
//  SalesmanAppTests
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import XCTest
@testable import SalesmanApp

final class SearchSalesmenUseCaseTests: XCTestCase {

    var mockSalesmenRepository: MockedSalesmenRepository!
    var useCase: DefaultSearchSalesmenUseCase!

    // MARK: - Set up

    override func setUp() {
        super.setUp()
        mockSalesmenRepository = MockedSalesmenRepository()
        useCase = DefaultSearchSalesmenUseCase(salesmenRepository: mockSalesmenRepository)
    }

    // MARK: - Tests

    func testSearchSalesmenUseCase_whenRepositoryReturnsFailure_thenUseCaseReturnsError() async throws {
        // given
        let dataSet = [
            MockedSalesmenRepository.oneFullAreaSalesman,
            MockedSalesmenRepository.justAsteriskAreaSalesman,
            MockedSalesmenRepository.noAreasSalesman
        ]
        mockSalesmenRepository.setDataSet(dataSet)
        mockSalesmenRepository.setResult(.failure(MockedSalesmenRepository.SalesmenRepositoryTestError.failedFetching))

        // when
        let searchText = "7"
        let result = await useCase.execute(searchText)

        // then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, MockedSalesmenRepository.SalesmenRepositoryTestError.failedFetching.localizedDescription)
        }
    }

    func testSearchSalesmenUseCase_whenThereIsNoSalesmen_thenUseCaseReturnsSuccessWithEmptyList() async throws {
        // given
        let dataSet: [Salesman] = []
        mockSalesmenRepository.setDataSet(dataSet)

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
            MockedSalesmenRepository.oneFullAreaSalesman,
            MockedSalesmenRepository.justAsteriskAreaSalesman,
            MockedSalesmenRepository.noAreasSalesman
        ]
        mockSalesmenRepository.setDataSet(dataSet)

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
            MockedSalesmenRepository.oneFullAreaSalesman,
            MockedSalesmenRepository.justAsteriskAreaSalesman,
            MockedSalesmenRepository.noAreasSalesman
        ]
        mockSalesmenRepository.setDataSet(dataSet)

        // when
        let searchText = "7"
        let result = await useCase.execute(searchText)

        // then
        let salesmen = try result.get()
        XCTAssertFalse(salesmen.contains(where: { $0.id == MockedSalesmenRepository.noAreasSalesman.id }))
    }

    func testSearchSalesmenUseCase_whenThereIsSalesmanWithJustAsteriskAndSearchTextDoesNotMatchAnythingElse_thenOnlySalesmanWithAsteriskIsReturned() async throws {
        // given
        let dataSet = [
            MockedSalesmenRepository.oneFullAreaSalesman,
            MockedSalesmenRepository.justAsteriskAreaSalesman,
            MockedSalesmenRepository.noAreasSalesman
        ]
        mockSalesmenRepository.setDataSet(dataSet)

        // when
        let searchText = "1234"
        let result = await useCase.execute(searchText)

        // then
        let salesmen = try result.get()
        XCTAssertTrue(salesmen.count == 1)
        XCTAssertTrue(salesmen.contains(where: { $0.id == MockedSalesmenRepository.justAsteriskAreaSalesman.id }))
    }

    func testSearchSalesmenUseCase_whenSearchTextMatchesTwoSalesmenWithAsterisks_thenOnlyTheseSalesmenAreReturned() async throws {
        // given
        let dataSet = [
            MockedSalesmenRepository.oneFullAreaSalesman,
            MockedSalesmenRepository.oneAsteriskAreaSalesman,
            MockedSalesmenRepository.twoAsteriskAreasSalesman,
            MockedSalesmenRepository.noAreasSalesman
        ]
        mockSalesmenRepository.setDataSet(dataSet)

        // when
        let searchText = "7436"
        let result = await useCase.execute(searchText)

        // then
        let salesmen = try result.get()
        XCTAssertTrue(salesmen.count == 2)
        XCTAssertTrue(salesmen.contains(where: { $0.id == MockedSalesmenRepository.oneAsteriskAreaSalesman.id }))
        XCTAssertTrue(salesmen.contains(where: { $0.id == MockedSalesmenRepository.twoAsteriskAreasSalesman.id }))
    }

    func testSearchSalesmenUseCase_whenSearchTextPresentsFullPostalcodeThatMatchesTwoSalesmen_thenOnlyTheseSalesmenAreReturned() async throws {
        // given
        let dataSet = [
            MockedSalesmenRepository.oneFullAreaSalesman,
            MockedSalesmenRepository.oneAsteriskAreaSalesman,
            MockedSalesmenRepository.twoAsteriskAreasSalesman,
            MockedSalesmenRepository.noAreasSalesman
        ]
        mockSalesmenRepository.setDataSet(dataSet)

        // when
        let searchText = "76543"
        let result = await useCase.execute(searchText)

        // then
        let salesmen = try result.get()
        XCTAssertTrue(salesmen.count == 2)
        XCTAssertTrue(salesmen.contains(where: { $0.id == MockedSalesmenRepository.oneFullAreaSalesman.id }))
        XCTAssertTrue(salesmen.contains(where: { $0.id == MockedSalesmenRepository.twoAsteriskAreasSalesman.id }))
    }

    func testSearchSalesmenUseCase_whenSearchTextExceedsMaxDigits_thenEmptyListIsReturned() async throws {
        // given
        let dataSet = [
            MockedSalesmenRepository.oneAsteriskAreaSalesman,
            MockedSalesmenRepository.justAsteriskAreaSalesman,
            MockedSalesmenRepository.noAreasSalesman
        ]
        mockSalesmenRepository.setDataSet(dataSet)

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
            MockedSalesmenRepository.oneAsteriskAreaSalesman,
            MockedSalesmenRepository.justAsteriskAreaSalesman,
            MockedSalesmenRepository.noAreasSalesman
        ]
        mockSalesmenRepository.setDataSet(dataSet)

        // when
        let searchText = "7436a"
        let result = await useCase.execute(searchText)

        // then
        let salesmen = try result.get()
        XCTAssertTrue(salesmen.count == 0)
    }
}
