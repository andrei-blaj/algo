func binarySearch<T: Comparable>(_ a: [T], key: T) -> Bool { // returning the index of the element if found

    var lo = 0
    var hi = a.count - 1

    while lo <= hi {
        let mid = (lo + hi) >> 1
        if a[mid] == key {
            return true
        } else if a[mid] < key {
            lo = mid + 1
        } else {
            hi = mid - 1
        }
    }

    return false
}

let numbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]

print(binarySearch(numbers, key: 44))
