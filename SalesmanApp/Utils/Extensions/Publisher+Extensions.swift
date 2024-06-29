//
//  Publisher+Extensions.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import Combine

extension Publisher where Self.Failure == Never {
    func sink(receiveValue: @escaping ((Self.Output) async -> Void)) -> AnyCancellable {
        sink { value in
            Task {
                await receiveValue(value)
            }
        }
    }
}
