//
//  SeatingOptionViewType.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/27/24.
//

import Foundation

enum SeatingOptionViewType: Equatable, Sendable {
    static let allOption = "All"

    case all
    case some([String])

    var optionsSet: [String] {
        switch self  {
        case .all: [SeatingOptionViewType.allOption]
        case .some(let set): Array(set)
        }
    }

    func isFilled(id: String) -> Bool {
        switch self {
        case .all:
            id == Self.allOption
        case .some(let set):
            set.contains(id)
        }
    }

    mutating func itemSelected(id: String) {
        switch self {
        case .all:
            self = .some([id])
        case .some(let set):
            let newSet = if set.contains(id) {
                if set.count != 1 {
                    set.filter { $0 != id}
                } else {
                    set
                }
            } else {
                set + [id]
            }

            self = .some(newSet)
        }
    }
}
