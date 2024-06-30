//
//  Font+Extensions.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import SwiftUI

extension Font {
    static let customFont: (Font.Weight, CGFloat) -> Font = { fontType, size in
        Font.system(size: size, weight: fontType)
    }
}

extension Text {
    func customFont(_ fontWeight: Font.Weight? = .regular, _ size: CGFloat? = nil) -> Text {
        return self.font(.customFont(fontWeight ?? .regular, size ?? 16))
    }
}
