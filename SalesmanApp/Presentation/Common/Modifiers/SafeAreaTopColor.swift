//
//  SafeAreaTopColor.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import SwiftUI

struct SafeAreaTopColor: ViewModifier {
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content

            GeometryReader { reader in
                Color.navBarBackground
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }
        }
    }
}

extension View {
    func applySafeAreaTopColor() -> some View {
        modifier(SafeAreaTopColor())
    }
}
