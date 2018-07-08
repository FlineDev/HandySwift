//
//  ColletionExtension.swift
//  HandySwift iOS
//
//  Created by Stepanov Pavel on 08/07/2018.
//  Copyright © 2018 Flinesoft. All rights reserved.
//

import Foundation

extension Collection {
    
    /// Returns an element with the specified index or nil if the element does not exist
    ///
    /// - Parameters:
    ///   - safe: The index of the element
    public subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
