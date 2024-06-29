//
//  AppDIContainer.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import SwiftUI

final class AppDIContainer {

    // MARK: - DIContainers of scenes

    func makeSalesmanDIContainer() -> SalesmanDIContainer {
        SalesmanDIContainer()
    }
}
