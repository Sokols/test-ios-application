//
//  FetchSalesmansUseCaseTests.swift
//  SalesmanAppTests
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import XCTest
@testable import SalesmanApp

final class FetchSalesmansUseCaseTests: XCTestCase {

    var mockSalesmansRepository: MockedSalesmansRepository!
    var useCase: DefaultFetchSalesmansUseCase!

    // MARK: - Set up

    override func setUp() {
        super.setUp()
        mockSalesmansRepository = MockedSalesmansRepository()
        useCase = DefaultFetchSalesmansUseCase(salesmansRepository: mockSalesmansRepository)
    }

    // MARK: - Tests

    func testFetchSalesmansUseCase_whenRepositoryReturnsFailure_thenUseCaseReturnsError() async throws {
        // given
        let dataSet = [
            MockedSalesmansRepository.oneFullAreaSalesman,
            MockedSalesmansRepository.justAsteriskAreaSalesman,
            MockedSalesmansRepository.noAreasSalesman
        ]
        mockSalesmansRepository.setDataSet(dataSet)
        mockSalesmansRepository.setResult(.failure(MockedSalesmansRepository.SalesmansRepositoryTestError.failedFetching))

        // when
        let result = await useCase.execute()

        // then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, MockedSalesmansRepository.SalesmansRepositoryTestError.failedFetching.localizedDescription)
        }
    }

    func testFetchSalesmansUseCase_whenRepositoryReturnsSuccess_thenUseCaseReturnsSuccessWithAllData() async throws {
        // given
        let dataSet = [
            MockedSalesmansRepository.oneFullAreaSalesman,
            MockedSalesmansRepository.justAsteriskAreaSalesman,
            MockedSalesmansRepository.noAreasSalesman
        ]
        mockSalesmansRepository.setDataSet(dataSet)

        // when
        let result = await useCase.execute()
        let salesmen = Set(try result.get())

        // then
        XCTAssertTrue(salesmen == Set(dataSet))
    }

    func testFetchSalesmansUseCase_whenRepositoryReturnsEmptyDataSet_thenUseCaseReturnsSuccessWithEmptyList() async throws {
        // given
        let dataSet: [Salesman] = []
        mockSalesmansRepository.setDataSet(dataSet)

        // when
        let result = await useCase.execute()
        let salesmen = Set(try result.get())

        // then
        XCTAssertTrue(salesmen == Set(dataSet))
        XCTAssertTrue(salesmen.isEmpty)
    }
}
