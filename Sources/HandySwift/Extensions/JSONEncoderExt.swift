import Foundation

extension JSONEncoder {
   /// A pre-configured JSONEncoder that automatically converts Swift's camelCase property names
   /// to snake_case when encoding JSON
   ///
   /// Instead of creating a new encoder and configuring it each time, this provides a ready-to-use
   /// encoder with snake_case conversion.
   ///
   /// Example usage:
   /// ```
   /// let user = User(firstName: "John", lastName: "Doe")
   /// let jsonData = try JSONEncoder.snakeCase.encode(user)
   /// // Results in: {"first_name": "John", "last_name": "Doe"}
   /// ```
   static var snakeCase: JSONEncoder {
      let encoder = JSONEncoder()
      encoder.keyEncodingStrategy = .convertToSnakeCase
      return encoder
   }
}
