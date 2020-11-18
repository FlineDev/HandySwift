// Copyright © 2020 Flinesoft. All rights reserved.

import Foundation

extension StringProtocol {
    /// Returns a variation with the first character uppercased.
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }

    /// Returns a variation with the first character capitalized.
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }

    /// Returns a variation with the first character lowercased.
    var firstLowercased: String { prefix(1).lowercased() + dropFirst() }
}
