//
//  SalesmanRow.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import SwiftUI

struct SalesmanRow: View {

    @State private var isExpanded = false
    let item: Salesman

    var body: some View {
        VStack {
            HStack{
                ContactCircleView(character: item.name.firstLetter())
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.name)
                        .customFont(.regular, 17)
                        .foregroundStyle(.textPrimary)
                    if isExpanded {
                        Text(item.areas.joined(separator: ", "))
                            .customFont(.regular, 15)
                            .foregroundStyle(.textSecondary)
                    }
                }
                Spacer()
                Button(action: { isExpanded.toggle() }) {
                    if isExpanded {
                        Image(.greyChevronDown)
                    } else {
                        Image(.greyChevronRight)
                    }
                }
            }
            .padding(.vertical, 16)
            Divider()
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    SalesmanRow(item: Salesman(name: "Artem Titarenko", areas: ["76133", "76133", "76133", "76133", "76133", "76133", "76133", "76133", "76133", "76133", "76133", "76133", "76133", "76133"]))
}
