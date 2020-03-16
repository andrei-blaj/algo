
func findKthElement<T: Comparable>(_ arr: [T], k: Int) -> T {
    
    var arr = arr
    var lo = 0
    var hi = arr.count - 1
    
    while true {
        
        let pivotIndex = getPivot(&arr, lo, hi)
        if pivotIndex == k {
            break
        }
        
        if k < pivotIndex {
            hi = pivotIndex - 1
        }
        
        if pivotIndex < k {
            lo = pivotIndex + 1
        }
    }
    
    return arr[k]
    
}

func getPivot<T: Comparable>(_ arr: inout [T], _ lo: Int, _ hi: Int) -> Int {
    
    let pivot = arr[hi]
    
    var i = lo
    var j = lo
    
    while j < hi {
        if arr[j] <= pivot {
            arr.swapAt(i, j)
            i += 1
        }
        j += 1
    }
    arr.swapAt(i, hi)
    return i
}

// K starting from 0
print(findKthElement([1, 10, 4, 13, 7, 6, 11, 14], k: 2))


