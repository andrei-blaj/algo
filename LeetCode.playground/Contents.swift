import Cocoa

func titleToNumber(_ s: String) -> Int {
    
    let n = s.count
    var p = Int(truncating: NSDecimalNumber(decimal: pow(26, n - 1)))
    var sol = 0
    
    for letter in s {
        let letterIndex = Int(letter.asciiValue! - Character("A").asciiValue!) + 1
        sol += p * letterIndex
        p /= 26
    }
    
    return sol
}

func isHappy(_ n: Int) -> Bool {
 
    var n = n
    var history: [Int] = []
    
    while true {
        if history.contains(n) || n == 1 {
            break
        }
        
        history.append(n)
        
        var m = n
        var newN = 0
        while m > 0 {
            let digit = m % 10
            newN += digit * digit
            m /= 10
        }
        print(newN)
        n = newN
        
    }
    
    return n == 1
}

//isHappy(19)

func merge(_ intervals: [[Int]]) -> [[Int]] {
    
    if intervals.count <= 1 { return intervals }
    
    let intervals = intervals.sorted(by: { $0[0] < $1[0] })
    var output: [[Int]] = []
    var currentInterval = intervals[0]
    
    for i in 1..<intervals.count {
        let currentIntervalEnd = currentInterval[1]
        let newIntervalStart = intervals[i][0]
        let newIntervalEnd = intervals[i][1]
        
        if currentIntervalEnd >= newIntervalStart {
            currentInterval[1] = max(currentIntervalEnd, newIntervalEnd)
        } else {
            output.append(currentInterval)
            currentInterval = intervals[i]
        }
    }
    
    output.append(currentInterval)
    
    return output
}

//print(merge([[1,3],[15,18],[2,6],[8,10]]))

func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        
    if beginWord == endWord || !wordList.contains(endWord) { return 0 }
    
    let n = beginWord.count
    var newWordList: [String: Bool] = [:]
    var queue: [(String, Int)] = []
    queue.append((beginWord, 1))

    for word in wordList {
        newWordList[word] = true
    }

    while !queue.isEmpty {
        let currentWord = queue.first!.0
        let step = queue.first!.1

        queue.removeFirst()

        let wordArray = Array(currentWord)

        for i in 0..<n {
            for c in 0..<26 {
                let char = Character(UnicodeScalar(Character("a").asciiValue! + UInt8(c)))
                var word = wordArray
                word[i] = char
                let wordStr = String(word)
                if newWordList[wordStr] != nil {
                    if wordStr == endWord {
                        return step + 1
                    }
                    queue.append((wordStr, step + 1))
                    newWordList.removeValue(forKey: wordStr)
                }
            }
        }
    }
    return 0
}

/**************************************************/

func generateParenthesis(_ n: Int) -> [String] {
    var output: [String] = []
    backtrack(&output, "", 0, 0, n)
    return output
}

func backtrack(_ output: inout [String], _ currentPermutation: String, _ openCount: Int, _ closeCount: Int, _ n: Int) {
    
    if currentPermutation.count == n * 2 {
        output.append(currentPermutation)
        return
    }
    
    if openCount < n {
        backtrack(&output, currentPermutation + "(", openCount + 1, closeCount, n)
    }
    
    if closeCount < openCount {
        backtrack(&output, currentPermutation + ")", openCount, closeCount + 1, n)
    }
    
}
