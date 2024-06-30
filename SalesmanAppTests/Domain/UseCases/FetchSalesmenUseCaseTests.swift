//
//  FetchSalesmenUseCaseTests.swift
//  SalesmanAppTests
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import XCTest
@testable import SalesmanApp

final class FetchSalesmenUseCaseTests: XCTestCase {

    var mockSalesmenRepository: MockedSalesmenRepository!
    var useCase: DefaultFetchSalesmenUseCase!

    // MARK: - Set up

    override func setUp() {
        super.setUp()
        mockSalesmenRepository = MockedSalesmenRepository()
        useCase = DefaultFetchSalesmenUseCase(salesmenRepository: mockSalesmenRepository)
    }

    // MARK: - Tests

    func testFetchSalesmenUseCase_whenRepositoryReturnsFailure_thenUseCaseReturnsError() async throws {
        // given
        let dataSet = [
            MockedSalesmenRepository.oneFullAreaSalesman,
            MockedSalesmenRepository.justAsteriskAreaSalesman,
            MockedSalesmenRepository.noAreasSalesman
        ]
        mockSalesmenRepository.setDataSet(dataSet)
        mockSalesmenRepository.setResult(.failure(MockedSalesmenRepository.SalesmenRepositoryTestError.failedFetching))

        // when
        let result = await useCase.execute()

        // then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, MockedSalesmenRepository.SalesmenRepositoryTestError.failedFetching.localizedDescription)
        }
    }

    func testFetchSalesmenUseCase_whenRepositoryReturnsSuccess_thenUseCaseReturnsSuccessWithAllData() async throws {
        // given
        let dataSet = [
            MockedSalesmenRepository.oneFullAreaSalesman,
            MockedSalesmenRepository.justAsteriskAreaSalesman,
            MockedSalesmenRepository.noAreasSalesman
        ]
        mockSalesmenRepository.setDataSet(dataSet)

        // when
        let result = await useCase.execute()
        let salesmen = Set(try result.get())

        // then
        XCTAssertTrue(salesmen == Set(dataSet))
    }

    func testFetchSalesmenUseCase_whenRepositoryReturnsEmptyDataSet_thenUseCaseReturnsSuccessWithEmptyList() async throws {
        // given
        let dataSet: [Salesman] = []
        mockSalesmenRepository.setDataSet(dataSet)

        // when
        let result = await useCase.execute()
        let salesmen = Set(try result.get())

        // then
        XCTAssertTrue(salesmen == Set(dataSet))
        XCTAssertTrue(salesmen.isEmpty)
    }
}
