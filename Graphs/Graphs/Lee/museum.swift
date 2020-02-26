//
//  Museum.swift
//  Graphs
//
//  Created by Andrei Blaj on 2/26/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import Foundation

func museumProblem() {
    let nmax = 250
    let museumTestFile = "museum.txt"
    
    var A = Array(repeating: Array(repeating: " ", count: nmax), count: nmax)
    var V = Array(repeating: Array(repeating: 0, count: nmax), count: nmax)
    var n: Int
    var startPoints: [(Int, Int)] = []
    
    let lines = readData(from: museumTestFile).components(separatedBy: "\n").joined()
    
    
    n = Int(String(lines.first!))!
    
    var i = 0
    var j = 0
    
    for char in lines.dropFirst() {
        A[i][j] = String(char)
        
        if A[i][j] == "#" {
            V[i][j] = -2
        } else if A[i][j] == "P" {
            V[i][j] = 0
            startPoints.append((i, j))
        } else {
            V[i][j] = -1
        }

        j += 1
        if j == n {
            j = 0
            i += 1
        }
    }
    
    computeSolution(A: A, n: n, V: &V, startPoints: startPoints)
    
    for i in 0..<n {
        for j in 0..<n {
            print(V[i][j], terminator: " ")
        }
        print("\n")
    }
    
}

func computeSolution(A: [[String]], n: Int, V: inout [[Int]], startPoints: [(Int, Int)]) {
    
    for startPoint in startPoints {
        var queue = Queue<(Int, Int)>(items: [])
        queue.push(startPoint)
        
        while !queue.isEmpty() {
            guard let currentCell = queue.pop() else { break }
            
            let i = currentCell.0
            let j = currentCell.1
            
            if i - 1 >= 0 && A[i - 1][j] == "." && (V[i - 1][j] > V[i][j] + 1 || V[i - 1][j] == -1) {
                queue.push((i - 1, j))
                V[i - 1][j] = V[i][j] + 1
            }
            
            if j - 1 >= 0 && A[i][j - 1] == "." && (V[i][j - 1] > V[i][j] + 1 || V[i][j - 1] == -1) {
                queue.push((i, j - 1))
                V[i][j - 1] = V[i][j] + 1
            }
            
            if i + 1 < n && A[i + 1][j] == "." && (V[i + 1][j] > V[i][j] + 1 || V[i + 1][j] == -1) {
                queue.push((i + 1, j))
                V[i + 1][j] = V[i][j] + 1
            }
            
            if j + 1 < n && A[i][j + 1] == "." && (V[i][j + 1] > V[i][j] + 1 || V[i][j + 1] == -1) {
                queue.push((i, j + 1))
                V[i][j + 1] = V[i][j] + 1
            }
            
        }
        
    }
    
}
