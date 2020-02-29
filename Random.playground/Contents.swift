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


