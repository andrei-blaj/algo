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
    var queue: [String] = []

    visited.append("0000")
    queue.append("0000")
    var level = 0

    while !queue.isEmpty {
        var size = queue.count
        while size > 0 {
            let currentCombination = queue.removeFirst()
            
            if deadends.contains(currentCombination) {
                size -= 1
                continue
            }

            if currentCombination == target { return level }

            var comb1 = Array(currentCombination)
            var comb2 = comb1
            for i in 0..<4 {
                comb1 = Array(currentCombination)
                comb2 = comb1
                if let digit = Int(String(comb1[i])) {
                    let digit1 = (digit + 1) % 10
                    comb1[i] = Character(String(digit1))

                    var digit2 = digit - 1
                    if digit2 < 0 {
                        digit2 = 10 + digit2
                    }
                    comb2[i] = Character(String(digit2))

                    let strComb1 = String(comb1)
                    let strComb2 = String(comb2)

                    if !visited.contains(strComb1) && !deadends.contains(strComb1) {
                        queue.append(strComb1)
                        visited.append(strComb1)
                    }

                    if !visited.contains(strComb2) && !deadends.contains(strComb2) {
                        queue.append(strComb2)
                        visited.append(strComb2)
                    }

                }
            }
            size -= 1
        }
        level += 1
    }

    return -1
    
}

//openLock(["8887","8889","8878","8898","8788","8988","7888","9888"], "8888")

func subdomainVisits(_ cpdomains: [String]) -> [String] {
    
    var sol: [String] = []
    var dict: [String: Int] = [:]
    
    for cpdomain in cpdomains {
    
        let componenets = cpdomain.split(separator: " ")
        let cnt = Int(componenets[0])!
        
        let domainComponents = componenets[1].split(separator: ".")
        var cmpStr = ""
        for cmp in domainComponents.reversed() {
            
            if cmpStr == "" {
                cmpStr += String(cmp)
            } else {
                cmpStr = String(cmp) + "." + cmpStr
            }
            
            if dict[cmpStr] == nil {
                dict[cmpStr] = cnt
            } else {
                dict[cmpStr]! += cnt
            }
        }
        
    }
    
    for (key, value) in dict {
        sol.append(String(value) + " " + key)
    }
    
    return sol
    
}

//print(subdomainVisits(["900 google.mail.com", "50 yahoo.com", "1 intel.mail.com", "5 wiki.org"]))

func findOcurrences(_ text: String, _ first: String, _ second: String) -> [String] {
    
    var wordArray: [String] = []
    var sol: [String] = []
    
    let words = text.split(separator: " ")
    for word in words {
        wordArray.append(String(word))
    }
    
    for i in 0..<wordArray.count - 2 {
        if wordArray[i] == first && wordArray[i + 1] == second {
            sol.append(wordArray[i + 2])
        }
    }
    
    return sol
}

//findOcurrences("we will we will rock you", "we", "will")

func rotatedDigits(_ N: Int) -> Int {
    
    var sol = 0
    
    for x in 1...N {
        
        var noGood = false
        let str = Array(String(x))
        var newX = 0
        for letter in str {
            
            if letter == "3" || letter == "4" || letter == "7" {
                noGood = true
                break
            }

            newX = newX * 10
            if letter == "5" {
                newX += 2
            } else if letter == "2" {
                newX += 5
            } else if letter == "6" {
                newX += 9
            } else if letter == "9" {
                newX += 6
            } else {
                newX += Int(String(letter))!
            }
            
        }
        
        if noGood {
            continue
        }
        
        if x != newX {
            sol += 1
        }
        
    }
    
    return sol
    
}

// rotatedDigits(10)

func reverseWords(_ s: String) -> String {
    
    var words: [String] = []
    
    var word = ""
    for char in s {
        if char == " " {
            if word != "" {
                words.append(word)
            }
            word = ""
        } else {
            word += String(char)
        }
    }
    
    if word != "" {
        words.append(word)
    }
    
    var sol = ""
    for i in stride(from: words.count - 1, to: -1, by: -1) {
        sol += words[i] + " "
    }
    
    sol.removeLast()
    
    return sol
}

//reverseWords("a good example")

func thirdMax(_ nums: [Int]) -> Int {
    
    if nums.count == 0 { return 0 }
    if nums.count == 1 { return nums[0] }
    if nums.count == 2 { return max(nums[0], nums[1]) }
    
    var max1: Int?
    var max2: Int?
    var max3: Int?
    
    for i in 0..<nums.count {
        
        let num = nums[i]
        
        if let m1 = max1, let m2 = max2, let m3 = max3 {
            if num == m1 || num == m2 || num == m3 {
                continue
            }
        }
        
        if max1 == nil || num > max1! {
            max3 = max2
            max2 = max1
            max1 = num
        } else if max2 == nil || num > max2! {
            max3 = max2
            max2 = num
        } else if max3 == nil || num > max3! {
            max3 = num
        }
        
    }
    
    if max3 == nil {
        return max1!
    }
    
    return max3!
}

