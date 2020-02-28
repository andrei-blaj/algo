let n = 7
let V: [Int] = [5, -6, 3, 4, -2, 3, -3]

var best = Array(repeating: 0, count: 7)
best[0] = V[0]
var sol = -1<<30

for i in 1..<n {
    best[i] = max(best[i - 1] + V[i], V[i])
    sol = max(sol, best[i])
}

print(sol)
