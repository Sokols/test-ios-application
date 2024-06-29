//
//  ContentView.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        #warning("TODO: Implement correct navigation and DI")
        NavigationView {
            NavigationLink(destination: SalesmanAddressesListView(viewModel: DefaultSalesmanAddressesViewModel(fetchSalesmansUseCase: DefaultFetchSalesmansUseCase(salesmansRepository: DefaultSalesmansRepository()), searchSalesmenUseCase: DefaultSearchSalesmenUseCase(salesmansRepository: DefaultSalesmansRepository())))) {
                Text("Addresses")
            }
        }
    }
}

#Preview {
    ContentView()
}
