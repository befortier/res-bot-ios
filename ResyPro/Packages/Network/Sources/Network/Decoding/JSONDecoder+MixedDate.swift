public import Foundation

extension JSONDecoder {
    public static func mixedDateDecoder() -> JSONDecoder {
        let d = JSONDecoder()

        // (1) One ISO-8601 formatter for the timestamps
        let iso = ISO8601DateFormatter()
        iso.formatOptions = [.withInternetDateTime]        // “2025-05-30T18:30:00Z”

        // (2) One short formatter for the plain dates
        let short = DateFormatter()
        short.dateFormat = "yyyy-MM-dd"                    // “2025-05-30”
        short.timeZone   = TimeZone.gmt
        short.locale     = .init(identifier: "en_US_POSIX")  // safe default

        // (3) Try both, in that order
        d.dateDecodingStrategy = .custom { decoder in
            let c = try decoder.singleValueContainer()
            let s = try c.decode(String.self)
            if let date = iso.date(from: s)   { return date }
            if let date = short.date(from: s) { return date }
            throw DecodingError.dataCorruptedError(
                in: c,
                debugDescription: "Unrecognised date: \(s)"
            )
        }
        return d
    }
}
