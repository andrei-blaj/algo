let n = 12
let p = 10
let k = 5
let pomi: [(Int, Int)] = [(4, 3), (5, 5), (6, 8), (7, 3), (7, 7), (8, 8), (9, 3), (9, 6), (10, 10), (11, 5)]

var A = Array(repeating: Array(repeating: 0, count: n), count: n)
var S = A

var solMax = -1
var solCount = 0

for pomIndex in 0..<p {
    let i = pomi[pomIndex].0
    let j = pomi[pomIndex].1
    
    A[i-1][j-1] = 1
    S[i-1][j-1] = 1
}

//for i in 0..<n {
//    for j in 0..<n {
//        print(A[i][j], terminator: " ")
//    }
//    print("")
//}

for i in 0..<n {
    for j in 0..<n {
        if i > 0 && j > 0 {
            S[i][j] += S[i - 1][j] + S[i][j - 1] - S[i - 1][j - 1]
        } else if i > 0 {
            S[i][j] += S[i - 1][j]
        } else if j > 0 {
            S[i][j] += A[i][j - 1]
        }
    }
}

//print("\n")
//
//for i in 0..<n {
//    for j in 0..<n {
//        print(S[i][j], terminator: " ")
//    }
//    print("")
//}

for i in k..<n {
    for j in k..<n {
        let val = S[i][j] - S[i - k][j] - S[i][j - k] + S[i - k][j - k]
        if val > solMax {
            solMax = val
            solCount = 1
        } else if val == solMax {
            solCount += 1
        }
    }
}

print(solMax, solCount)




