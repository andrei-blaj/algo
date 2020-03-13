// Generate permutations of the array: [1, 2, 3]

func generatePermutations<T: Comparable>(_ arr: [T]) {
    let n = arr.count
    var indexArray = Array(repeating: 0, count: n)
    backtrack(arr, n, 0, &indexArray)
}

func backtrack<T: Comparable>(_ arr: [T], _ n: Int, _ k: Int, _ indexArray: inout [Int]) {
    for i in 0..<n {
        indexArray[k] = i
        
        var uniqueIndexes = true
        for j in 0..<k {
            if indexArray[j] == indexArray[k] {
                uniqueIndexes = false
                break
            }
        }
        
        if uniqueIndexes {
            if k == n - 1 {
                for j in 0..<n {
                    print(arr[indexArray[j]], terminator: " ")
                }
                print("")
            } else {
                backtrack(arr, n, k + 1, &indexArray)
            }
        }
        
    }
}

//generatePermutations([1, 2, 3])

func generateCombinations<T: Comparable>(_ arr: [T], _ m: Int) {
    let n = arr.count
    var indexArray = Array(repeating: 0, count: m)
    backtrack(arr, n, m, 0, &indexArray)
}

func backtrack<T: Comparable>(_ arr: [T], _ n: Int, _ m: Int, _ k: Int, _ indexArray: inout [Int]) {
    
    for i in 0..<n {
        indexArray[k] = i
        
        var uniqueIndexes = true
        for j in 0..<k {
            if indexArray[j] == indexArray[k] || indexArray[j] > indexArray[k] {
                uniqueIndexes = false
                break
            }
        }
        
        if uniqueIndexes {
            if k == m - 1 {
                for j in 0..<m {
                    print(arr[indexArray[j]], terminator: " ")
                }
                print("")
            } else {
                backtrack(arr, n, m, k + 1, &indexArray)
            }
        }
        
    }
    
}

generateCombinations([1,2,3,4], 3)
