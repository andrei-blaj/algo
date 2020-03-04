func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
    
    if nums.count == 0 { return 0 }
    
    var sums = Array(repeating: 0, count: nums.count + 1)
    sums[1] = nums[0]
    
    for i in 1..<nums.count {
        sums[i + 1] = sums[i] + nums[i]
    }
    
    // nums: 2, 3, 1, 2, 4, 3
    // sum: 2, 5, 6, 8, 12, 15
    
    let lo = 1
    let hi = nums.count
    return explore(sums, s, lo, hi)
    
}

// Returns the length of the shortest subarray that has the sum >= s
func explore(_ sums: [Int], _ s: Int, _ lo: Int, _ hi: Int) -> Int {
    
    if lo == hi {
        return sums.count - 1
    }
    
    if sums[hi] - sums[lo - 1] >= s {
        let mid = lo + (hi - lo) / 2
        return min(hi - lo, min(explore(sums, s, lo, mid), explore(sums, s, mid + 1, hi)))
    }
        
    return sums.count - 1
    
}

minSubArrayLen(11, [1,2,3,4,5,1])


//var visited: [[Bool]] = []

//func exist(_ board: [[Character]], _ word: String) -> Bool {
//
//    let n = board.count
//    let m = board[0].count
//
//    for i in 0..<n {
//        for j in 0..<m {
//            visited = Array(repeating: Array(repeating: false, count: m), count: n)
//            let firstCharacter = word[word.index(word.startIndex, offsetBy: 0)]
//            if board[i][j] == firstCharacter && searchWord(i, j, 0, word, board) {
//                return true
//            }
//        }
//    }
//
//    return false
//}
//
//func searchWord(_ i: Int, _ j: Int, _ index: Int, _ word: String, _ board: [[Character]]) -> Bool {
//
//    if i >= board.count || i < 0 || j >= board[0].count || j < 0 || board[i][j] != word[word.index(word.startIndex, offsetBy: index)] || visited[i][j] {
//        return false
//    }
//
//    if index == word.count - 1  {
//        return true
//    }
//
//    visited[i][j] = true
//
//    if searchWord(i + 1, j, index + 1, word, board) ||
//       searchWord(i - 1, j, index + 1, word, board) ||
//       searchWord(i, j + 1, index + 1, word, board) ||
//       searchWord(i, j - 1, index + 1, word, board) {
//           return true
//       }
//
//    visited[i][j] = false
//
//    return false
//}

//print(exist([["A","B","C","E"], ["S","F","E","S"], ["A","D","E","E"]], "ABFEED"))

var visited: [[Bool]] = []

func maxAreaOfIsland(_ grid: [[Int]]) -> Int {
    
    if grid.count == 0 || grid[0].count == 0 { return 0 }
    
    let n = grid.count
    let m = grid[0].count
    var maxArea = 0
    visited = Array(repeating: Array(repeating: false, count: m), count: n)
    
    for i in 0..<n {
        for j in 0..<m {
            if grid[i][j] == 1 && !visited[i][j] {
                let currentArea = explore(i, j, grid)
                maxArea = max(maxArea, currentArea)
            }
            
        }
    }
    
    return maxArea
    
}

func explore(_ i: Int, _ j: Int, _ grid: [[Int]]) -> Int {
    
    if i < 0 || i >= grid.count || j < 0 || j >= grid[0].count || grid[i][j] == 0 || visited[i][j] {
        return 0
    }
    
    visited[i][j] = true
    
    return 1 + explore(i + 1, j, grid) + explore(i - 1, j, grid) + explore(i, j + 1, grid) + explore(i, j - 1, grid)
}

maxAreaOfIsland([[1,1,0,0,0],[1,1,0,0,0],[0,0,0,1,1],[0,0,0,1,1]])

func openLock(_ deadends: [String], _ target: String) -> Int {
    
    var visited: [String] = []
    var queue: [(String, Int)] = []
    
    visited.append("0000")
    queue.append(("0000", 0))
    
    while !queue.isEmpty {
        
        let front = queue.removeFirst()
        let currentCombination = front.0
        let currentIndex = front.1
        
        print(currentCombination, currentIndex )
        
        if deadends.contains(currentCombination) { continue }
        
        if currentCombination == target {
            return currentIndex
        }

        var comb = Array(currentCombination)
        
        for i in 0..<4 {
            for j in 0...9 {
                comb[i] = Character(String(j))
                let strComb = String(comb)
                if !visited.contains(strComb) && !deadends.contains(strComb) {
                    queue.append((strComb, currentIndex + 1))
                    visited.append(strComb)
                }
            }
        }
        
    }
    
    return -1
    
}

openLock(["0201","0101","0102","1212","2002"], "0202")
