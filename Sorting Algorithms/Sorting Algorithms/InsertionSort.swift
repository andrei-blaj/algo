//
//  InsertionSort.swift
//  Sorting Algorithms
//
//  Created by Andrei Blaj on 2/26/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import Foundation

public func insertionSort<T: Comparable>(_ array: [T]) -> [T] {
    var a = array
    for i in 1..<a.count {
        var j = i
        let temp = a[j]
        while j > 0 && temp < a[j - 1] {
            a[j] = a[j - 1]
            j -= 1
        }
        a[j] = temp
    }
    return a
}
