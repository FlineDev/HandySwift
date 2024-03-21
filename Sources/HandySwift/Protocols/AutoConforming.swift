import Foundation

/// Adds conformance to the automatically inferrable protocols `Hashable`, `Codable`, and `Sendable`.
public typealias AutoConforming = Hashable & Codable & Sendable
