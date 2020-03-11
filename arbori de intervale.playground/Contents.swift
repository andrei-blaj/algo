var maximum = -1

func update(_ arb: inout [Int], _ node: Int, _ i: Int, _ val: Int, _ lo: Int, _ hi: Int) {
    
    if lo == hi {
        arb[node] = val
        return
    }
    
    let mid = lo + (hi - lo) / 2
    
    if i <= mid {
        update(&arb, 2 * node, i, val, lo, mid)
    } else {
        update(&arb, 2 * node + 1, i, val, mid + 1, hi)
    }
    
    arb[i] = max(arb[2 * i], arb[2 * i + 1])
    
}

func solveQueryForInteral(_ arb: inout [Int], _ node: Int, _ lo: Int, _ hi: Int, _ a: Int, _ b: Int) {
    
    if a <= lo && hi <= b {
        maximum = max(maximum, arb[node])
    }

    let mid = lo + (hi - lo) / 2
    
    if a <= mid {
        solveQueryForInteral(&arb, 2 * node, lo, mid, a, b)
    }
    
    if mid < b {
        solveQueryForInteral(&arb, 2 * node + 1, mid + 1, hi, a, b)
    }
    
}

func solveQueries(_ n: Int, _ m: Int, _ initialArray: [Int], _ queries: [(Int, Int, Int)]) {
    
    var arb = Array(repeating: 0, count: n * 4 + 1)
    
    for i in 0..<n {
        update(&arb, 1, i + 1, initialArray[i], 1, n)
    }
    
    for query in queries {
        let type = query.0
        let a = query.1
        let b = query.2
        
        if type == 0 {
            maximum = -1
            
            print(maximum)
        } else {
            update(&arb, 1, a, b, 1, n)
        }
        
    }
    
}

