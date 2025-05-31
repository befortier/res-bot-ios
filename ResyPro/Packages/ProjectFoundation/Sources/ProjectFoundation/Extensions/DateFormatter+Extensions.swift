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

extension DateIntervalFormatter {
    public static func standardString(_ interval: DateInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"

        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short

        let day = dateFormatter.string(from: interval.start)
        let startTime = timeFormatter.string(from: interval.start)
        let endTime = timeFormatter.string(from: interval.end)

        return "\(day) · \(startTime)–\(endTime)"
    }
}
