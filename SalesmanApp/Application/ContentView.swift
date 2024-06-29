//
//  ContentView.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import SwiftUI

struct ContentView: View {

    let diContainer: AppDIContainer

    var body: some View {
        #warning("TODO: Implement correct navigation and DI")
        NavigationView {
            NavigationLink(destination: diContainer.makeSalesmanDIContainer().makeSalesmanAddresssesListView()) {
                Text("Addresses")
            }
        }
    }
}

#Preview {
    ContentView(diContainer: AppDIContainer())
}
