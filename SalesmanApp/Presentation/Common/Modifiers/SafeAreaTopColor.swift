//
//  SafeAreaTopColor.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import SwiftUI

struct SafeAreaTopColor: ViewModifier {
    let color: Color

    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content

            GeometryReader { reader in
                color
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }
        }
    }
}

extension View {
    func applySafeAreaTopColor(_ color: Color) -> some View {
        modifier(SafeAreaTopColor(color: color))
    }
}
