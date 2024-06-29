//
//  SalesmanAddressListViewTests.swift
//  SalesmanAppUITests
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import XCTest

final class SalesmanAddressListViewTests: XCTestCase {

    // MARK: - Set up

    override func setUpWithError() throws {
        try super.setUpWithError()

        continueAfterFailure = false
    }

    // MARK: - Tests

    // NOTE: for UI tests to work the keyboard of simulator must be on.
    // Keyboard shortcut COMMAND + SHIFT + K while simulator has focus
    func testOpenAddresses_whenSearchThatDoesNotMatchAnythingTyped_thenNoAddressesMessageIsReturned() {
        let app = XCUIApplication()
        app.launch()

        app.navigateToSalesmenAddressesListView()

        let failureSearchText = "99999"
        app.typeTextInSearchField(failureSearchText)

        XCTAssertTrue(app.staticTexts[AccessibilityIdentifier.noAddressesText].waitForExistence(timeout: 2))
    }
}
