/*
 Given a string, find the longest substring which contains  2 unique characters. ""abcbbbbcccbdddadacb" => "bcbbbbcccb"
 */

func findLongestSubstring(_ s: String) -> String {
    
    if s.count <= 2 {
        return s
    }
    
    var s = Array(s)
    s.append(".")
    
    var prev = s[0]
    var curr = s[1]
    var lastOccuranceOfCurr = 1
    
    var start = 0
    var soli = 0
    var solj = 1
    var solLen = 2
    
    
    for i in 2..<s.count {
        
        if s[i] == prev {
            let aux = curr
            curr = prev
            prev = aux
            lastOccuranceOfCurr = i
            continue
        }
        
        if s[i] == curr {
            continue
        }
        
        if i - start > solLen {
            solLen = i - start
            soli = start
            solj = i - 1
        }
        
        start = lastOccuranceOfCurr
        prev = curr
        curr = s[i]
        
    }
    
    var sol = ""
    
    for i in soli...solj {
        sol += String(s[i])
    }
    
    return sol
    
}

findLongestSubstring("abcbbbbcccbdddadacb")
