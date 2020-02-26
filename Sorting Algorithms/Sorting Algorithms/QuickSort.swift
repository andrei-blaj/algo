//
//  QuickSort.swift
//  Sorting Algorithms
//
//  Created by Andrei Blaj on 2/25/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import Foundation

public func quickSort<T: Comparable>(_ a: inout [T], lo: Int, hi: Int) {
    if lo < hi {
        let pivot = partition(&a, lo: lo, hi: hi)
        quickSort(&a, lo: lo, hi: pivot - 1)
        quickSort(&a, lo: pivot + 1, hi: hi)
    }
    
}

public func partition<T: Comparable>(_ a: inout [T], lo: Int, hi: Int) -> Int {
    
    // we choose the last element of the array as our pivot
    let pivot = a[hi]
    var i = lo
    
    for j in lo..<hi {
        if a[j] <= pivot {
            a.swapAt(i, j)
            i += 1
        }
    }
    
    a.swapAt(i, hi)
    
    return i
    
}
