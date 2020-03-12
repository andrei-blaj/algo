
func mergeSort<T: Comparable>(_ arr: [T]) -> [T] {
    
    guard arr.count > 1 else { return arr }
    
    let mid = arr.count / 2
    let left = mergeSort(Array(arr[0..<mid]))
    let right = mergeSort(Array(arr[mid..<arr.count]))
    
    return merge(left, right)
    
}

func merge<T: Comparable>(_ left: [T], _ right: [T]) -> [T] {
    
    var mergedArray: [T] = []
    var i = 0
    var j = 0
    
    while i < left.count && j < right.count {
        if left[i] < right[j] {
            mergedArray.append(left[i])
            i += 1
        } else {
            mergedArray.append(right[j])
            j += 1
        }
    }
    
    while i < left.count {
        mergedArray.append(left[i])
        i += 1
    }
    
    while j < right.count {
        mergedArray.append(right[j])
        j += 1
    }
    
    return mergedArray
}

//print(mergeSort(["a", "z", "u", "d", "r", "e", "c"]))

/**************************************************************************/

func quickSort<T: Comparable>(_ arr: inout [T], _ lo: Int, _ hi: Int) {
    print(arr, lo, hi)
    if lo < hi {
        let p = getPivot(&arr, lo, hi)
        quickSort(&arr, lo, p - 1)
        quickSort(&arr, p + 1, hi)
    }
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
    
    arr.swapAt(i, j)
    return i
    
}

var a = [2, 5, 3, 7, 1, 8, 6, 4]
quickSort(&a, 0, a.count - 1)
print(a)
