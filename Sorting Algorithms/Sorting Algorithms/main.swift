//
//  main.swift
//  Sorting Algorithms
//
//  Created by Andrei Blaj on 2/25/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import Foundation

var example: [Int] = [7, 1, 5, 3, 9, 2, 6, 4, 8]

//print(mergeSort(example))

quickSort(&example, lo: 0, hi: example.count - 1)
print(example)

