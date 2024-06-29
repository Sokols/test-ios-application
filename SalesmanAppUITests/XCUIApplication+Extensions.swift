//
//  XCUIApplication+Extensions.swift
//  SalesmanAppUITests
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import XCTest
@testable import SalesmanApp

extension XCUIApplication {
    
    func navigateToSalesmenAddressesListView() {
        otherElements.buttons[AccessibilityIdentifier.addressesButton].tap()
    }

    func typeTextInSearchField(_ text: String) {
        textFields[AccessibilityIdentifier.searchField].tap()
        textFields[AccessibilityIdentifier.searchField].typeText(text)
        buttons[AccessibilityIdentifier.keyboardDoneButton].tap()
    }
}
