import Foundation

extension CaseIterable {
   /// Returns an array containing all cases of the conforming type, with `nil` prefixed.
   /// This can be especially useful in SwiftUI Pickers where you want to offer an option
   /// to not select any value. For example, in a Picker view for selecting an optional
   /// category, prefixing with `nil` allows users to explicitly select 'None' as an option.
   ///
   /// Example for SwiftUI:
   /// ```swift
   /// enum Category: String, CaseIterable {
   ///     case books, movies, music
   /// }
   ///
   /// @State private var selectedCategory: Category? = nil
   ///
   /// var body: some View {
   ///     Picker("Category", selection: $selectedCategory) {
   ///         Text("None").tag(Category?.none)
   ///         ForEach(Category.allCasesPrefixedByNil, id: \.self) { category in
   ///             Text(category?.rawValue.capitalized ?? "None").tag(category as Category?)
   ///         }
   ///     }
   /// }
   /// ```
   /// - Returns: An array of optional values including `nil` followed by all cases of the type.
   public static var allCasesPrefixedByNil: [Self?] {
      [.none] + self.allCases.map(Optional.init)
   }

   /// Returns an array containing all cases of the conforming type, with `nil` suffixed.
   /// While similar to `allCasesPrefixedByNil`, this variation is useful when the 'None'
   /// option is more logically placed at the end of the list in the UI. This can align with
   /// user expectations in certain contexts, where selecting 'None' or 'Not specified' is
   /// considered an action taken after reviewing all available options.
   ///
   /// Example for SwiftUI:
   /// ```swift
   /// enum Level: String, CaseIterable {
   ///     case beginner, intermediate, advanced
   /// }
   ///
   /// @State private var selectedLevel: Level? = nil
   ///
   /// var body: some View {
   ///     Picker("Level", selection: $selectedLevel) {
   ///         ForEach(Level.allCasesSuffixedByNil, id: \.self) { level in
   ///             Text(level?.rawValue.capitalized ?? "None").tag(level as Level?)
   ///         }
   ///     }
   /// }
   /// ```
   /// - Returns: An array of optional values including all cases of the type followed by `nil`.
   public static var allCasesSuffixedByNil: [Self?] {
      self.allCases.map(Optional.init) + [.none]
   }
}
