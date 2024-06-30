//
//  Array+Extensions.swift
//  SalesmanApp
//
//  Created by Igor SOKÓŁ on 29/06/2024.
//

import Foundation

extension Array where Element == Salesman {

    /**
     Assumptions:
     - "searchText" cannot exceed "maxDigits" (5 by default) - returns empty array for that case.
     - empty "searchText" returns all data
     - "searchText" can contain only digits - returns empty array if other characters are present
     */
    func filter(with searchText: String, maxDigits: Int = 5) -> [Salesman] {
        if searchText.isEmpty {
            return self
        }
        if searchText.count > maxDigits || Int(searchText) == nil {
            return []
        }
        return self.filter { salesman in
            for area in salesman.areas {
                if areaMatchesPostcode(area, searchText: searchText) {
                    return true
                }
            }
            return false
        }
    }

    private func areaMatchesPostcode(_ area: String, searchText: String) -> Bool {
        if area.hasSuffix("*") {
            let areaPrefix = String(area.dropLast())
            if areaPrefix.count >= searchText.count {
                return areaPrefix.hasPrefix(searchText)
            } else {
                return searchText.hasPrefix(areaPrefix)
            }
        } else {
            return area.hasPrefix(searchText)
        }
    }
}
