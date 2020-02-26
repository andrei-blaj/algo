//
//  labirint.swift
//  Graphs
//
//  Created by Andrei Blaj on 2/26/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import Foundation

// Se dă o matrice cu M linii şi N coloane. Ştiind locul de plecare, marcat cu -1, se cere să se determine drumul de lungime minimă până la o ieşire, iar in caz că nu există, se va afişa -1

func labirintProblem() {

    let nmax = 1000
    let labirintTestFile = "labirint.txt"

    var A = Array(repeating: Array(repeating: 0, count: nmax), count: nmax)
    var V = Array(repeating: Array(repeating: INT_MAX, count: nmax), count: nmax)
    var n, m: Int
    var k = 2
    var startPoint: (Int, Int) = (0, 0)
    
    let lines = readData(from: labirintTestFile).split(separator: "\n")
    var elements = [String]()
    
    for line in lines {
        elements += line.components(separatedBy: " ")
    }
    
    n = Int(elements[0])!
    m = Int(elements[1])!
    
    for i in 0..<n {
        for j in 0..<m {
            A[i][j] = Int(elements[k])!
            k += 1
            
            if A[i][j] == -1 {
                startPoint = (i, j)
            }
        }
    }
    
    // Alternative
//    startPoint = getStartPoint(from: A, n: n, m: m)
    
    let sol = computeSolution(A: &A, n: n, m: m, V: &V, startPoint: startPoint)
    
    print(sol)
    
}

func computeSolution(A: inout [[Int]], n: Int, m: Int, V: inout [[Int32]], startPoint: (Int, Int)) -> Int32 {
    
    var queue = Queue<(Int, Int)>(items: [])
    var solution = INT_MAX
    
    queue.push(startPoint)
    V[startPoint.0][startPoint.1] = 0
    
    while !queue.isEmpty() {
        guard let currentCell = queue.pop() else { break }
        
        let i = currentCell.0
        let j = currentCell.1
        
        if i == 0 || i == n - 1 || j == 0 || j == m - 1 && i != startPoint.0 && j != startPoint.1 {
            solution = min(solution, Int32(V[i][j]))
        }
        
        if i - 1 >= 0 && A[i - 1][j] == 0 && V[i][j] + 1 < V[i - 1][j]  {
            queue.push((i - 1, j))
            V[i - 1][j] = V[i][j] + 1
        }
        
        if j - 1 >= 0 && A[i][j - 1] == 0 && V[i][j] + 1 < V[i][j - 1] {
            queue.push((i, j - 1))
            V[i][j - 1] = V[i][j] + 1
        }
        
        if i + 1 < n && A[i + 1][j] == 0 && V[i][j] + 1 < V[i + 1][j]  {
            queue.push((i + 1, j))
            V[i + 1][j] = V[i][j] + 1
        }
        
        if j + 1 < m && A[i][j + 1] == 0 && V[i][j] + 1 < V[i][j + 1]  {
            queue.push((i, j + 1))
            V[i][j + 1] = V[i][j] + 1
        }
        
    }
    
    return solution == INT_MAX ? -1 : solution
    
}


func getStartPoint(from A: [[Int]], n: Int, m: Int) -> (Int, Int) {
    for i in 0..<n {
        for j in 0..<m {
            if A[i][j] == -1 {
                return (i, j)
            }
        }
    }
    return (0, 0)
}
