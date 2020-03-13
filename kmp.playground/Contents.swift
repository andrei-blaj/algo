
func buildPrefixTable(forString str: String) -> [Int] {
    
    let str = Array(str)
    let n = str.count
    var prefixTable = Array(repeating: 0, count: n)
    
    var i = 0
    var j = 1
    
    while j < n {
        if str[j] == str[i] {
            prefixTable[j] = i + 1
            i += 1
        } else {
            i = 0
        }
        j += 1
    }
    
    prefixTable.insert(0, at: 0)
    
    return prefixTable
    
}

func matchString(_ str: String, _ pattern: String) {
    
    let prefixTable = buildPrefixTable(forString: pattern)
    let str = Array(str)
    let pattern = Array(pattern)
    
    let n = str.count
    let m = pattern.count
    var i = 0
    var j = 1
    
    while i + m - 1 < n {
        
        var k = i
        
        while j <= m && pattern[j - 1] == str[k] {
            k += 1
            j += 1
        }
        
        print(j)
        
        if j > m {
            print(i)
        }
        
        if prefixTable[j - 1] > 0 {
            i = k - prefixTable[j - 1] + 1
        } else {
            if k == i { k += 1 }
            i = k
        }
        
        if j > 1 {
            j = prefixTable[j - 1] + 1
        }
        
    }
    
}

matchString("cozacocacolacococacola", "cocacola")
