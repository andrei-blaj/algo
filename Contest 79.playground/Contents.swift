func numOfMinutes(_ n: Int, _ headID: Int, _ manager: [Int], _ informTime: [Int]) -> Int {
    var maxTime = 0
    var employee: [[Int]] = Array(repeating: [], count: manager.count)
    var visited: [Bool] = Array(repeating: false, count: manager.count)
    var root = 0
    
    for (i, m) in manager.enumerated() {
        if m != -1 {
            employee[m].append(i)
        } else {
            root = i
        }
    }
    
    var queue: [(Int, Int)] = []
    queue.append((root, 0))
    visited[root] = true
    
    while !queue.isEmpty {
        let pair = queue.removeFirst()
        let node = pair.0
        let time = pair.1
        
        maxTime = max(maxTime, time)
        
        for child in employee[node] {
            if !visited[child] {
                visited[child] = true
                queue.append((child, time + informTime[node]))
            }
        }
        
    }
    
    return maxTime
}

