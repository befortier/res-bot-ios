//
//  DateFormatter+Extensions.swift
//  ProjectFoundation
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

extension DateIntervalFormatter {
    public static let short: DateIntervalFormatter = {
        let dateFormatter = DateIntervalFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
}

extension DateFormatter {
    public static let short: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
}
