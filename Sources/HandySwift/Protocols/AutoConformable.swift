import Foundation

/// Adds conformance to the automatically inferrable protocols ``Hashable``, ``Codable``, and ``Sendable``.
public typealias AutoConformable = Hashable & Codable & Sendable
