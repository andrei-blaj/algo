let N = 12
let T = 10
let K = 5
let trees: [(Int, Int)] = [(4, 3), (5, 5), (6, 8), (7, 3), (7, 7), (8, 8), (9, 3), (9, 6), (10, 10), (11, 5)]

var A = Array(repeating: Array(repeating: 0, count: N), count: N)
var S = A

var solMax = -1
var solCount = 0

for treeIndex in 0..<T {
    let i = trees[treeIndex].0
    let j = trees[treeIndex].1
    
    A[i - 1][j - 1] = 1
    S[i - 1][j - 1] = 1
}

for i in 0..<N {
    for j in 0..<N {
        if i > 0 && j > 0 {
            S[i][j] += S[i - 1][j] + S[i][j - 1] - S[i - 1][j - 1]
        } else if i > 0 {
            S[i][j] += S[i - 1][j]
        } else if j > 0 {
            S[i][j] += A[i][j - 1]
        }
    }
}

for i in K..<N {
    for j in K..<N {
        let val = S[i][j] - S[i - K][j] - S[i][j - K] + S[i - K][j - K]
        if val > solMax {
            solMax = val
            solCount = 1
        } else if val == solMax {
            solCount += 1
        }
    }
}

print(solMax, solCount)




