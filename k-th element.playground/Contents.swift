var array =  [7, 92, 23, 9, -1, 0, 11, 6]

func randomPivot<T: Comparable>(_ a: inout [T], _ lo: Int, _ hi: Int) -> T {
    let pivotIndex = Int.random(in: lo...hi)
    a.swapAt(pivotIndex, hi)
    return a[hi]
}

func randomizedPartition<T: Comparable>(_ array: inout [T], lo: Int, hi: Int) -> Int {
    let pivot = randomPivot(&array, lo, hi)
    var i = lo
    
    for j in lo..<hi {
        if array[j] <= pivot {
            array.swapAt(i, j)
            i += 1
        }
    }
    array.swapAt(i, hi)
    return i
}

func randomizedSelect<T: Comparable>(_ array: inout [T], lo: Int, hi: Int, k: Int) -> T {
    
    if lo < hi {
    
        let pivotIndex = randomizedPartition(&array, lo: lo, hi: hi)
        
        if pivotIndex == k {
            return array[pivotIndex]
        } else if k < pivotIndex {
            return randomizedSelect(&array, lo: lo, hi: pivotIndex - 1, k: k)
        } else {
            // k > pivotIndex
            return randomizedSelect(&array, lo: pivotIndex + 1, hi: hi, k: k)
        }
        
    } else {
         return array[lo]
    }
    
}

randomizedSelect(&array, lo: 0, hi: array.count - 1, k: 0)
