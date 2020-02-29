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
