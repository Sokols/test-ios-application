//
//  SalesmanApp.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import SwiftUI

@main
struct SalesmanApp: App {

    private let diContainer = AppDIContainer()

    var body: some Scene {
        WindowGroup {
            ContentView(diContainer: diContainer)
        }
    }
}
