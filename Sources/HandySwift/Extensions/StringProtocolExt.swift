// Copyright © 2020 Flinesoft. All rights reserved.

import Foundation

extension StringProtocol {
  /// Returns a variation with the first character uppercased.
  public var firstUppercased: String { prefix(1).uppercased() + dropFirst() }

  /// Returns a variation with the first character capitalized.
  public var firstCapitalized: String { prefix(1).capitalized + dropFirst() }

  /// Returns a variation with the first character lowercased.
  public var firstLowercased: String { prefix(1).lowercased() + dropFirst() }
}
