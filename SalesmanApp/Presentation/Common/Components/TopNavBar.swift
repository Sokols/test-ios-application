//
//  TopNavBar.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import SwiftUI

struct TopNavBar: View {

    let title: String
    let backButtonAction: () -> Void

    var body: some View {
        ZStack {
            Color.navBarBackground
            HStack {
                Button(action: backButtonAction) {
                    Image(uiImage: .chevronLeft)
                }
                .padding(.leading, 16)
                Spacer()
            }
            Text(title)
                .customFont(.semibold, 15)
                .foregroundStyle(.navBarPrimary)
        }
        .frame(height: 48)
    }
}

#Preview {
    TopNavBar(title: "Addresses") {}
}
