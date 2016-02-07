//
//  FrequencyTable.swift
//  HandySwift
//
//  Created by Cihat Gündüz on 03.01.16.
//  Copyright © 2016 Flinesoft. All rights reserved.
//

import Foundation

public struct FrequencyTable<T> {

    // MARK: - Stored Instance Properties
    
    private let valuesWithFrequencies: [(T, Int)]
    private let frequentValues: [T]
    
    
    // MARK: - Initializers
    
    public init(values: [T], frequencyClosure: (T) -> Int) {
        
        self.valuesWithFrequencies = values.map { ($0, frequencyClosure($0)) }
        self.frequentValues = Array(self.valuesWithFrequencies.map { (value, frequency) -> [T] in
            return (0..<frequency).map { _ in value }
        }.flatten())
        
    }
    
    
    // MARK: - Instance Methods
    
    public var sample: T? {
        get {
            return frequentValues.sample
        }
    }
    
    public func sample(size size: Int) -> [T]? {
        
        if !self.frequentValues.isEmpty {
            var sampleElements: [T] = []
            
            size.times {
                sampleElements.append(self.sample!)
            }
            
            return sampleElements
        }
        
        return nil
    }

    
}
