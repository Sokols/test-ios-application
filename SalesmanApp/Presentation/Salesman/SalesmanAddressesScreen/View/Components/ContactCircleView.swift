//
//  ContactCircleView.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import SwiftUI

struct ContactCircleView: View {

    let character: String?

    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(.contactCircleStroke, lineWidth: 1)
                .background(Circle().foregroundColor(.contactCircleBackground))
                .frame(width: 42, height: 42)
            Text(character ?? "")
                .customFont(.regular, 17)
                .foregroundStyle(.textPrimary)
        }
    }
}

#Preview {
    ContactCircleView(character: "A")
}
