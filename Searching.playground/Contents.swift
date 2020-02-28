/// 1. Linear Search
/// Find an element in an array

/// Returns the index
let array = [5, 2, 4, 7]

func linearSearch<T: Equatable>(_ array: [T], _ element: T) -> Int? {
    for (index, elem) in array.enumerated() {
        if element == elem {
            return index
        }
    }
    return nil
}

linearSearch(array, 2)

/// 2. Binary Search
let numbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]

func binarySearch<T: Comparable>(_ array: [T], _ element: T) -> Int? {
    
    var lo = 0
    var hi = array.count
    
    while lo <= hi {
        let mid = (hi + lo) >> 1
        if array[mid] == element {
            return mid
        } else if array[mid] > element {
            hi = mid - 1
        } else {
            lo = mid + 1
        }
    }
    
    return nil
    
}

binarySearch(numbers, 43)

/// 3. Count Occurances
let a = [ 0, 1, 1, 3, 3, 3, 3, 6, 8, 10, 11, 11]

func countOccurances<T: Comparable>(of key: T, in array: [T]) -> Int {
    
    var leftBound: Int {
        var lo = 0
        var hi = array.count - 1
        
        while lo < hi {
            let mid = (lo + hi) >> 1
            if array[mid] < key {
                lo = mid + 1
            } else {
                hi = mid
            }
        }
        
        return lo
    }
    
    var rightBound: Int {
        var lo = 0
        var hi = array.count - 1
        
        while lo < hi {
            let mid = (lo + hi) >> 1
            if array[mid] > key {
                hi = mid
            } else {
                lo = mid + 1
            }
        }
        
        return lo
    }
    
    return rightBound - leftBound
}

countOccurances(of: 3, in: a)
