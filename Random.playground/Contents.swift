func gcdOfStrings(_ str1: String, _ str2: String) -> String {
    if str1 + str2 != str2 + str1 { return "" }
    
    let len = gcd(str1.count, str2.count)
    return String(str1.prefix(len))
}

func gcd(_ a: Int, _ b: Int) -> Int {
    if b == 0 { return a}
    return gcd(b, a % b)
}

gcdOfStrings("ABABAB", "ABAB")

func letterCombinations(_ digits: String) -> [String] {
       
    if digits.contains("1") || digits.contains("0") {
        return []
    }
    
    var solution: [String] = []
    var solutionLen = 1
    let letters: [String: [String]] = [
                                       "2": ["a", "b", "c"],
                                       "3": ["d", "e", "f"],
                                       "4": ["g", "h", "i"],
                                       "5": ["j", "k", "l"],
                                       "6": ["m", "n", "o"],
                                       "7": ["p", "q", "r", "s"],
                                       "8": ["t", "u", "v"],
                                       "9": ["w", "x", "y", "z"]
                                      ]
    
    for char in digits {
        solutionLen *= letters[String(char)]!.count
    }
    
    solution = Array(repeating: "", count: solutionLen)
    var frequency = solutionLen
    
    for char in digits {
        let str = String(char)
        let len = letters[str]!.count
        
        // after how many characters should we move on to printing the next one from the list
        frequency /= len
        var index = -1
        var letter = ""
        
        for i in 0..<solutionLen {
            if i % frequency == 0 {
                index += 1
                index = index % len
            }
            letter = letters[str]![index]
            solution[i] += letter
        }
    }

    return solution
       
}

//print(letterCombinations("272"))


extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

func longestPalindrome(_ s: String) -> String {
    
    if s == "" {
        return ""
    }
    
    let stringArray = Array(s)
    
    var start = 0
    var end = 0
    
    for i in 0..<stringArray.count {
        // 2 scenarios
        // racecar
        // aabbaa
        let len1 = expandFromMiddle(stringArray, left: i, right: i)
        let len2 = expandFromMiddle(stringArray, left: i, right: i + 1)
        let len = max(len1, len2)
        
        if len > end - start {
            start = i - (len - 1) / 2
            end = i + len / 2
        }
    }
    
    return String(stringArray[start...end])
}

func expandFromMiddle(_ s: [Character], left: Int, right: Int) -> Int {
    
    var left = left
    var right = right
    
    while left >= 0 && right < s.count && s[left] == s[right] {
        left -= 1
        right += 1
    }
    
    return right - left - 1
    
}

longestPalindrome("racecar")


// Given an array of N numbers (positive or negative integers) and K, calculate the subsequence, of length at least K, that has the largest sum.

// i, j and sum

let v = [2, -3, 5, 1, -4, 4, 12, -14, -5, 22, 32]
// k = 2

// brute force
func subsequence(_ a: [Int], k: Int) -> (Int, Int, Int) {
    
    var s: [Int] = Array(repeating: 0, count: a.count)
    s[0] = a[0]
    
    for i in 1..<a.count {
        s[i] = a[i] + s[i-1]
    }
    
    var soli = 0
    var solj = 0
    var sol = -1000000000
    
    for i in k...a.count {
        for j in 0...(a.count - i) {
            
            let upperBound = s[j + i - 1]
            let lowerBound = j == 0 ? 0 : s[j - 1]
            
            if upperBound - lowerBound > sol {
                sol = upperBound - lowerBound
                soli = j
                solj = j + i - 1
            }
        }
    }
    
    return (soli, solj, sol)
}

subsequence(v, k: 2)

// optimized
// ssm
func maximumSumSubsequence(_ a: [Int]) -> Int {
    
    // s[i] - the maximum sum of a subsequence from (0...i) of any length
    var s: [Int] = Array(repeating: 0, count: a.count)
    s[0] = a[0]
    
    var sol = -1000000000
    
    for i in 1..<a.count {
        s[i] = max(a[i], s[i - 1] + a[i])
        sol = max(sol, s[i])
    }
    
    return sol
    
}

maximumSumSubsequence(v)

let values = [-10,-3,0,5,9]
let middle = values.count / 2
values[middle]
[Int](values[0..<middle])
values[middle+1..<values.count]


func strStr_On2(_ haystack: String, _ needle: String) -> Int {
    
    if haystack == needle {
         return 0
    }
    
    if needle.count > haystack.count {
        return -1
    }
    
    let str = Array(haystack)
    let pattern = Array(needle)
    
    for i in 0..<str.count {
        var foundMatch = true
        for j in 0..<pattern.count {
            if str[i + j] != pattern[j] {
                foundMatch = false
                break
            }
        }
        if foundMatch {
            return i
        }
    }
    
    return -1
}

strStr_On2("abracadabra", "acada")

func strStrBoyerMoore(_ haystack: String, _ needle: String) -> Int {
    
    if haystack == needle || needle == "" { return 0 }
    if needle.count > haystack.count { return -1 }
    
    let str = Array(haystack)
    let pattern = Array(needle)
    
    let patternLength = pattern.count
    
    var skipTable: [String: Int] = [:]
    for (i, c) in pattern.enumerated() {
        skipTable[String(c)] = patternLength - i - 1
    }
    
    var i = patternLength - 1
    let lastChar = pattern[patternLength - 1]
    
    while i < str.count {
        let c = str[i]
        
        if c == lastChar {
            // check backwards to see if the other characters from the pattern
            // match the characters from the string
            
            var j = 1
            var matchFound = true
            while patternLength - 1 - j >= 0 {
                if str[i - j] == pattern[(patternLength - 1) - j] {
                    j += 1
                } else {
                    matchFound = false
                    break
                }
            }
            
            if matchFound {
                return i - patternLength + 1
            }
            
            if let skipBy = skipTable[String(c)] {
                i += max(skipBy, 1)
            } else {
                i += patternLength
            }
            
        } else {
            // if c is in the skip table, ship as many characters
            // as the skip table indicates
            // otherwise just skip one
            if let skipBy = skipTable[String(c)] {
                i += skipBy
            } else {
                i += patternLength
            }
        }
        
    }
    
    return -1
}

strStrBoyerMoore("abracadabra", "dabra")

func divideBySubtracting(_ dividend: Int, _ divisor: Int) -> Int {
    
    var quotient = 0
    var negative = false
    
    if dividend > 0 && divisor > 0 {
        negative = false
    } else {
        negative = true
    }
    
    var dividend = abs(dividend)
    let divisor = abs(divisor)
    
    while dividend > divisor {
        dividend -= divisor
        quotient += 1
    }
    
    if negative {
        return -1 * quotient
    } else {
        return quotient
    }
    
}

divideBySubtracting(10, 3)
divideBySubtracting(7, -3)

func closedIsland(_ grid: [[Int]]) -> Int {
    
    if grid.count == 0 {
        return 0
    }
    
    var islandCount = 0
    var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: grid[0].count), count: grid.count)
    
    let n = grid.count
    let m = grid[0].count
    
    for i in 0..<n {
        for j in 0..<m {
            if grid[i][j] == 0 && !visited[i][j] {
                if visitGrid(i: i, j: j, grid: grid, visited: &visited) {
                    islandCount += 1
                }
            }
        }
    }
      
    return islandCount
}
    
func visitGrid(i: Int, j: Int, grid: [[Int]], visited: inout [[Bool]]) -> Bool {
    
    let n = grid.count
    let m = grid[0].count
    var isIsland = true
    var order = [(Int, Int)]()
    
    order.append((i, j))
    
    while order.count > 0 {
        
        let coord = order.removeFirst()
        
        let i = coord.0
        let j = coord.1
        visited[i][j] = true
        
        if i == 0 || i == n - 1 || j == 0 || j == m - 1 {
            isIsland = false
        }
        
        if i - 1 >= 0 && !visited[i - 1][j] && grid[i - 1][j] == 0 {
            order.append((i - 1, j))
        }
        
        if i + 1 < n && !visited[i + 1][j] && grid[i + 1][j] == 0 {
            order.append((i + 1, j))
        }
        
        if j - 1 >= 0 && !visited[i][j - 1] && grid[i][j - 1] == 0 {
            order.append((i, j - 1))
        }
        
        if j + 1 < m && !visited[i][j + 1] && grid[i][j + 1] == 0 {
            order.append((i, j + 1))
        }
        
    }
    
    return isIsland
    
}

//let grid = [[1,1,1,1,1,1,1,0],[1,0,0,0,0,1,1,0],[1,0,1,0,1,1,1,0],[1,0,0,0,0,1,0,1],[1,1,1,1,1,1,1,0]]
let grid = [[0,0,1,0,0],[0,1,0,1,0],[0,1,1,1,0]]
closedIsland(grid)

func validPalindrome(_ s: String) -> Bool {
    
    if s == String(s.reversed()) {
        return true
    }
    
    let sArray = Array(s)
    
    for i in 0..<sArray.count/2 {
        let j = sArray.count - 1 - i
        if sArray[i] != sArray[j] {
            return isPalindromeRange(sArray, i + 1, j) || isPalindromeRange(sArray, i, j - 1)
        }
    }

    return true
    
}

func isPalindromeRange(_ s: [Character], _ lo: Int, _ hi: Int) -> Bool {
    for i in lo...(lo + (hi - lo) / 2) {
        let j = hi - i + lo
        if s[i] != s[j] {
            return false
        }
    }
    return true
}

validPalindrome("abca")

func isAnagram(_ s: String, _ t: String) -> Bool {
    
    var frequency: [String: Int] = [:]
    
    for char in s {
        let strChar = String(char)
        if frequency[strChar] != nil {
            frequency[strChar]! += 1
        } else {
            frequency[strChar] = 1
        }
    }
    
    for char in t {
        let strChar = String(char)
        if frequency[strChar] == nil {
            return false
        }
        frequency[strChar]! -= 1
    }
    
    for element in frequency {
        if element.value != 0 {
            return false
        }
    }
    
    return true
    
}

func rankTeams(_ votes: [String]) -> String {
    
    // ["BCA","CAB","CBA","ABC","ACB","BAC"]
    
    if votes.count == 0 {
        return ""
    }
    
    var freq: [String: Int] = [:]
    var sortedFreq: [(String, Int)] = []

    for j in 0..<votes[0].count {
        for i in 0..<votes.count {
            let vote = Array(votes[i])
            let strChar = String(vote[j])
            if freq[strChar] != nil {
                freq[strChar]! += 1
            } else {
                freq[strChar] = 1
            }
        }
        sortedFreq = freq.sorted { $0.1 > $1.1 }
        
        freq = [:]
        for s in sortedFreq {
            freq[s.0] = s.1
        }
        
        print(freq)
        
    }
    
    var sol = ""
    for s in sortedFreq {
        sol += s.0
    }
    return sol
    
}

rankTeams(["WXYZ","XYZW"])
//rankTeams(["BCA","CAB","CBA","ABC","ACB","BAC"])
public class ListNode {
    public var val: Int
      public var next: ListNode?
      public init(_ val: Int) {
          self.val = val
          self.next = nil
      }
  }

public class TreeNode {
      public var val: Int
      public var left: TreeNode?
    public var right: TreeNode?
      public init(_ val: Int) {
         self.val = val
         self.left = nil
          self.right = nil
      }
  }

func isSubPath(_ head: ListNode?, _ root: TreeNode?) -> Bool {
    
    return isSubpath(head, root, head)
    
}
    
    
func isSubpath(_ head: ListNode?, _ root: TreeNode?, _ initialHead: ListNode?) -> Bool {
    
    if head == nil {
        return true
    }
    
    if root == nil {
        return false
    }
    
    if root?.val == head?.val {
        return isSubpath(head?.next, root?.left, initialHead) || isSubpath(head?.next, root?.right, initialHead) || isSubpath(initialHead, root?.left, initialHead) || isSubpath(initialHead, root?.right, initialHead)
    } else {
        return isSubpath(initialHead, root?.left, initialHead) || isSubpath(initialHead, root?.right, initialHead)
    }
}

var array = [1, 2, 3, 4]
array.removeLast()
print(array)

func toLowerCase(_ str: String) -> String {
    var result = ""
    
    for char in Array(str) {
        let strChar = String(char)
        if "A" <= strChar && strChar <= "Z" {
            // is uppercased
            let characterAscii = char.asciiValue!
            let lowercasedCharacterAscii = characterAscii + 32
            result += String(UnicodeScalar(lowercasedCharacterAscii))
        } else {
            result += strChar
        }
     }
    
    return result
}

toLowerCase("HeLlO")

print(String(UnicodeScalar(Character("c").asciiValue! - 32)))


func isNStraightHand(_ hand: [Int], _ W: Int) -> Bool {
    
    var freq: [Int: Int] = [:]
    
    for card in hand {
        if freq[card] == nil {
            freq[card] = 1
        } else {
            freq[card]! += 1
        }
    }
    
    var tuples = freq.sorted { $0.key < $1.key }
    freq = tuples.reduce(into: [:]) { $0[$1.0] = $1.1}
    
    tuples.removeFirst()
    
    print(freq)
    
    while tuples.count > 0 {
        
        let card = tuples.first!
        let cardNumber = card.0
        let cardFreq = card.1
        
        print("\(cardNumber): ", terminator: " ")
        for i in cardNumber..<(cardNumber + W) {
            print(freq[i], terminator: " ")
            if freq[i] == nil { return false }
            let count = freq[i]
            if count == 1 {
                freq.removeValue(forKey: i)
            } else {
                freq[i]! -= 1
            }
        }
        print("")
           
    }

    return true
    
}


func reverseOnlyLetters(_ S: String) -> String {
    
    var s = Array(S)
    var i = 0
    var j = S.count - 1
    
    while i < j {
        if isLetter(s[i]) && isLetter(s[j]) {
            s.swapAt(i, j)
            i += 1
            j -= 1
        } else {
            if !isLetter(s[i]) {
                i += 1
            } else {
                j -= 1
            }
        }
    }
    
    return String(s)
    
}

func isLetter(_ char: Character) -> Bool {
    let strChar = String(char)
    if "a" <= strChar && strChar <= "z" || "A" <= strChar && strChar <= "Z" {
        return true
    }
    return false
}

func spiralOrder(_ matrix: [[Int]]) -> [Int] {
    
    if matrix.count == 0 { return [] }
    var visited = Array(repeating: Array(repeating: false, count: matrix[0].count), count: matrix.count)
    
    var sol: [Int] = []
    
    var iLowerBound = 0
    var iUpperBound = matrix.count - 1
    
    var jLowerBound = 0
    var jUpperBound = matrix[0].count - 1
    
    while (iLowerBound <= iUpperBound && jLowerBound <= jUpperBound) {
        
        if jLowerBound <= jUpperBound {
            for j in jLowerBound...jUpperBound {
                if !visited[iLowerBound][j] {
                    visited[iLowerBound][j] = true
                    sol.append(matrix[iLowerBound][j])
                }
            }
        }
        
        iLowerBound += 1

        if iLowerBound <= iUpperBound {
            for i in iLowerBound...iUpperBound {
                if !visited[i][jUpperBound] {
                    visited[i][jUpperBound] = true
                    sol.append(matrix[i][jUpperBound])
                }
            }
        }
        
        jUpperBound -= 1

        if jLowerBound <= jUpperBound {
            for j in stride(from: jUpperBound, to: jLowerBound - 1, by: -1) {
                if !visited[iUpperBound][j] {
                    visited[iUpperBound][j] = true
                    sol.append(matrix[iUpperBound][j])
                }
            }
        }

        iUpperBound -= 1

        if iLowerBound <= iUpperBound {
            for i in stride(from: iUpperBound, to: iLowerBound - 1, by: -1) {
                if !visited[i][jLowerBound] {
                    visited[i][jLowerBound] = true
                    sol.append(matrix[i][jLowerBound])
                }
            }
        }

        jLowerBound += 1
    
    }
    
    return sol
    
}

func numUniqueEmails(_ emails: [String]) -> Int {
    
    var sol = 0
    var exists: [String] = []
    
    for email in emails {
        
        let emailComponents = email.split(separator: "@")
        let domainName = emailComponents[1]
        let localNameComponent = emailComponents[0].split(separator: "+")
        let localNameTrimmed = String(localNameComponent[0])
        var localName = ""
        
        for letter in localNameTrimmed {
            if letter != "." {
                localName += String(letter)
            }
        }
        
        if localName + "@" + domainName == email {
            // 1 address
            if !exists.contains(email) {
                sol += 1
                exists.append(email)
            }
        } else {
            // 2 addresses
            if !exists.contains(localName) {
                sol += 2
                exists.append(localName)
            }
        }
        
    }

    return sol
}


func uniqueMorseRepresentations(_ words: [String]) -> Int {
    
    var sol = 0
    var exists: [String] = []
    let morseTable = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
    
    for word in words {
        var newWord = ""
        for letter in word {
            let letterAscii = letter.asciiValue!
            let aAscii = Character("a").asciiValue!
            
            let tableIndex = Int(letterAscii - aAscii)
            let letterCode = morseTable[tableIndex]
            
            newWord += letterCode
        }
        
        if !exists.contains(newWord) {
            exists.append(newWord)
            sol += 1
        }
        
    }
    
    return sol
    
}

func commonChars(_ A: [String]) -> [String] {
    
    var sol: [String] = []
    var freqForString: [[Int]] = Array(repeating: Array(repeating: 0, count: 26), count: A.count)
    
    for (i, str) in A.enumerated() {
        for character in str {
            freqForString[i][Int(character.asciiValue! - Character("a").asciiValue!)] += 1
        }
    }
    
    for i in 0..<26 {
        let letter = String(UnicodeScalar(Character("a").asciiValue! + UInt8(i)))
        var minFreq = freqForString[i][0]
        for j in 1..<A.count {
            minFreq = min(minFreq, freqForString[i][j])
        }
        for j in 0..<minFreq {
            sol.append(letter)
        }
    }
    
    return sol
}

