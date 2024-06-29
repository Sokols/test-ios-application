//
//  SearchBar.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import Combine
import SwiftUI

//struct SearchBar: UIViewRepresentable {
//
//    @Binding var text: String
//
//    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
//        let searchBar = UISearchBar(frame: .zero)
//        return searchBar
//    }
//
//    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
//        uiView.text = text
//    }
//}

struct SearchBar: View {

    @Binding var text: String
    private let textLimit: Int
    private let keyboardType: UIKeyboardType

    @FocusState private var isInputActive: Bool

    init(text: Binding<String>,
         textLimit: Int = 5,
         keyboardType: UIKeyboardType = .numberPad) {
        self._text = text
        self.textLimit = textLimit
        self.keyboardType = keyboardType
    }

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .onReceive(Just(text), perform: { _ in
                    limitText()
                })
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.textSecondary)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        Group {
                            if isInputActive {
                                Button(action: {
                                    self.text = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.textSecondary)
                                }
                            } else{
                                Image("microphone")
                            }
                        }
                        .padding(.trailing, 8)
                    }
                )
                .padding(.horizontal, 10)
                .accessibilityIdentifier(AccessibilityIdentifier.searchField)
                .keyboardType(keyboardType)
                .focused($isInputActive)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()

                        Button("Done") {
                            isInputActive = false
                        }
                        .accessibilityIdentifier(AccessibilityIdentifier.keyboardDoneButton)
                    }
                }
            if isInputActive {
                Button(action: {
                    self.isInputActive = false
                    self.text = ""

                }) {
                    Text("Cancel")
                        .customFont(.regular, 17)
                        .foregroundStyle(.textPrimary)
                }
                .padding(.trailing, 20)
                .transition(.move(edge: .trailing))
            }
        }
        .frame(maxHeight: 36)
    }

    private func limitText() {
        if text.count > textLimit {
            text = String(text.prefix(textLimit))
        }
    }
}

#Preview {
    SearchBar(text: .constant("test"))
}
