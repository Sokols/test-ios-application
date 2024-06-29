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
        NavigationView {
            NavigationLink(destination: addressesView) {
                Text("Addresses")
            }
        }
    }

    private var addressesView: some View {
        diContainer.makeSalesmanDIContainer().makeSalesmanAddresssesListView()
    }
}

#Preview {
    ContentView(diContainer: AppDIContainer())
}
