//
//  EmptyDecodable.swift
//  Network
//
//  Created by Ben Fortier on 5/18/25.
//

/// A placeholder type used to decode empty responses.
public struct EmptyDecodable: Decodable, ExpressibleByNilLiteral {
  public init(nilLiteral: ()) {}
  public init(from decoder: Decoder) throws {}
}
