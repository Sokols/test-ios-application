//
//  SalesmanRow.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import SwiftUI

struct SalesmanRow: View {

    @State private var isExpanded = false
    private let primaryText: String
    private let secondaryText: String

    init(item: Salesman) {
        self.primaryText = item.name
        self.secondaryText = item.areas.joined(separator: ", ")
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                ContactCircleView(character: primaryText.firstLetter())
                VStack(alignment: .leading, spacing: 2) {
                    Text(primaryText)
                        .customFont(.regular, 17)
                        .foregroundStyle(.textPrimary)
                        .lineLimit(isExpanded ? nil : 1)
                        .padding(.top, isExpanded ? 0 : 10)
                    if isExpanded {
                        Text(secondaryText)
                            .customFont(.regular, 15)
                            .foregroundStyle(.textSecondary)
                    }
                }

                Spacer()
                Group {
                    if isExpanded {
                        Image(.greyChevronDown)
                    } else {
                        Image(.greyChevronRight)
                    }
                }
                .onTapGesture {
                    isExpanded.toggle()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            .padding(.leading, 16)
            .padding(.vertical, 16)
            Divider()
                .padding(.leading, 16)
        }
        .frame(minHeight: 68)
    }
}

#Preview {
    SalesmanRow(item: SalesmanTestData.data.first!)
}
