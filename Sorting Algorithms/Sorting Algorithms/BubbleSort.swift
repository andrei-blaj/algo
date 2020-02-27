//
//  BubbleSort.swift
//  Sorting Algorithms
//
//  Created by Andrei Blaj on 2/26/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import Foundation

public func bubbleSort<T: Comparable>(_ a: inout [T]) {
    for i in 0..<a.count {
        for j in i+1..<a.count {
            if a[i] >= a[j] {
                a.swapAt(i, j)
            }
        }
    }
}
