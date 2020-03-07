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

/**************************************************/

func minRemoveToMakeValid(_ s: String) -> String {
    
    var stack: [Character] = []
    
    for letter in s {
        if letter == "(" {
            stack.append(letter)
        } else if letter == ")" {
            if !stack.isEmpty && stack.last! == "(" {
                stack.removeLast()
            } else {
                stack.append(letter)
            }
        }
    }
    
    if stack.isEmpty {
        return s
    }
    
    var output = Array(s)
    
    var i = 0
    while i < output.count && !stack.isEmpty {
        if output[i] == stack.first! {
            output.remove(at: i)
            stack.removeFirst()
        } else {
            i += 1
        }
    }
    
    return String(output)
    
}

/**************************************************/

func findTheLongestSubstring(_ s: String) -> Int {
    
    if s == "" { return 0 }
    
    var s = Array(s)
    var n = s.count
    
    var a = 0
    var e = 0
    var i = 0
    var o = 0
    var u = 0
    
    var maxVal = 0
    
    for lo in 0..<n {
        a = 0
        e = 0
        i = 0
        o = 0
        u = 0
        for hi in lo..<n {
            if s[hi] == "a" { a += 1 }
            if s[hi] == "e" { e += 1 }
            if s[hi] == "i" { i += 1 }
            if s[hi] == "o" { o += 1 }
            if s[hi] == "u" { u += 1 }
            
            if a % 2 == 0 && e % 2 == 0 && i % 2 == 0 && o % 2 == 0 && u % 2 == 0 {
                maxVal = max(maxVal, hi - lo + 1)
            }
        }
    }
    
    return maxVal
    
}

func sortString(_ s: String) -> String {
    
    var freq = Array(repeating: 0, count: 26)
    var result = ""
    var letterCount = s.count
    
    for letter in s {
        let index = Int(letter.asciiValue! - Character("a").asciiValue!)
        freq[index] += 1
    }
    
    while letterCount > 0 {
        
        for i in 0..<26 {
            if freq[i] > 0 {
                let letter = String(UnicodeScalar(Character("a").asciiValue! + UInt8(i)))
                result.append(letter)
                freq[i] -= 1
                letterCount -= 1
            }
        }
        
        for i in stride(from: 25, to: -1, by: -1) {
            if freq[i] > 0 {
                let letter = String(UnicodeScalar(Character("a").asciiValue! + UInt8(i)))
                result.append(letter)
                freq[i] -= 1
                letterCount -= 1
            }
        }
    }
    
    return result
    
}
