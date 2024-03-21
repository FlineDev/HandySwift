import Foundation

/// A wrapper for storing unowned references to a `Wrapped` instance.
public struct Unowned<Wrapped> where Wrapped: AnyObject {
   /// The value of `Wrapped` stored as unowned reference
   public unowned var value: Wrapped

   /// Creates an instance that stores the given value.
   ///
   /// - Parameter value: The value to store as an unowned reference.
   public init(_ value: Wrapped) {
      self.value = value
   }
}

extension Unowned: CustomDebugStringConvertible where Wrapped: CustomDebugStringConvertible {
   /// A textual representation of this instance, suitable for debugging.
   public var debugDescription: String {
      value.debugDescription
   }
}

extension Unowned: Decodable where Wrapped: Decodable {
   /// Creates a new instance by decoding from the given decoder.
   ///
   /// - Parameter decoder: The decoder to read data from.
   /// - Throws: An error if reading from the decoder fails, or if the data read is corrupted or otherwise invalid.
   public init(from decoder: Decoder) throws {
      self.value = try Wrapped(from: decoder)
   }
}

extension Unowned: Equatable where Wrapped: Equatable {
   /// Returns a Boolean value indicating whether two instances are equal.
   ///
   /// - Parameters:
   ///   - lhs: The left-hand side unowned reference to compare.
   ///   - rhs: The right-hand side unowned reference to compare.
   /// - Returns: `true` if the two instances are equal, `false` otherwise.
   public static func == (lhs: Unowned<Wrapped>, rhs: Unowned<Wrapped>) -> Bool {
      lhs.value == rhs.value
   }
}

extension Unowned: Encodable where Wrapped: Encodable {
   /// Encodes this value into the given encoder.
   ///
   /// - Parameter encoder: The encoder to write data to.
   /// - Throws: An error if any value throws an error during encoding.
   public func encode(to encoder: Encoder) throws {
      try value.encode(to: encoder)
   }
}
