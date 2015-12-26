//
//  SortedArray.swift
//  HandySwift
//
//  Created by Cihat Gündüz on 26.12.15.
//  Copyright © 2015 Flinesoft. All rights reserved.
//

import UIKit

public struct SortedArray<Element: Comparable> {
    
    // MARK: - Stored Instance Properties
    
    private var internalArray: Array<Element> = []
    
    public var array: Array<Element> {
        get {
            return self.internalArray
        }
    }
    
    
    // MARK: - Initializers
    
    public init(array: [Element]) {
        self.init(array: array, preSorted: false)
    }
    
    private init(array: [Element], preSorted: Bool) {
        if preSorted {
            self.internalArray = array
        } else {
            self.internalArray = array.sort()
        }
        
    }
    
    
    // MARK: - Instance Methods
    
    public func firstMatchingIndex(predicate: Element -> Bool) -> Array<Element>.Index? {
        
        // check if all elements match
        if let firstElement = self.array.first {
            if predicate(firstElement) {
                return self.array.startIndex
            }
        }
        
        // check if no element matches
        if let lastElement = self.array.last {
            if !predicate(lastElement) {
                return nil
            }
        }
        
        // binary search for first matching element
        var predicateMatched = false
        
        var lowerIndex = self.array.startIndex
        var upperIndex = self.array.endIndex
        
        while lowerIndex != upperIndex {
            
            let middleIndex = lowerIndex.advancedBy(lowerIndex.distanceTo(upperIndex) / 2)
            
            if predicate(self.array[middleIndex]) {
                upperIndex = middleIndex
                predicateMatched = true
            } else {
                lowerIndex = middleIndex.advancedBy(1)
            }
            
        }
        
        if !predicateMatched {
            return nil
        }
        
        return lowerIndex
    }
    
    public func subArray(toIndex endIndex: Array<Element>.Index) -> SortedArray {
        
        let range = Range<Int>(start: self.array.startIndex, end: endIndex)
        let subArray = Array(self.array[range])
        
        return SortedArray(array: subArray, preSorted: true)
        
    }
    
    public func subArray(fromIndex startIndex: Array<Element>.Index) -> SortedArray {
        
        let range = Range<Int>(start: startIndex, end: self.array.endIndex)
        let subArray = Array(self.array[range])
        
        return SortedArray(array: subArray, preSorted: true)
        
    }
    
    public mutating func remove(atIndex index: Array<Element>.Index) {
        self.internalArray.removeAtIndex(index)
    }
    
}
