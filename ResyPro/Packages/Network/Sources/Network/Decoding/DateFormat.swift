//
//  DateFormat.swift
//  Network
//
//  Created by Ben Fortier on 5/30/25.
//

public import Foundation

/// Convenience enum so call-sites can pass either a built-in
/// strategy or a named custom formatter.
public enum DateFormat {
    /// Use one of JSONDecoder’s standard strategies.
    case strategy(JSONDecoder.DateDecodingStrategy)
    /// Provide a custom formatter (internally mapped to `.formatted(_)`).
    case custom(DateFormatter)

    var decoderStrategy: JSONDecoder.DateDecodingStrategy {
        switch self {
        case .strategy(let s):      return s
        case .custom(let fmt):      return .formatted(fmt)
        }
    }
}
