import Foundation

extension JSONDecoder {
   /// A pre-configured JSONDecoder that automatically converts snake_case JSON property names
   /// to camelCase when decoding into Swift types
   ///
   /// This decoder handles incoming JSON with snake_case keys and converts them to match
   /// Swift's camelCase property naming convention.
   ///
   /// Example usage:
   /// ```
   /// let jsonString = """
   /// {
   ///     "first_name": "John",
   ///     "last_name": "Doe"
   /// }
   /// """
   /// let user = try JSONDecoder.snakeCase.decode(User.self, from: jsonData)
   /// // Results in: User(firstName: "John", lastName: "Doe")
   /// ```
   static var snakeCase: JSONDecoder {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      return decoder
   }
}
