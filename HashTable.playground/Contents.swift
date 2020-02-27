import Foundation

public struct HashTable<Key: Hashable, Value> {
    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = [Element]
    private var buckets: [Bucket]
    
    private(set) public var count = 0
    
    public var isEmpty: Bool { return count == 0 }

    public init(capacity: Int) {
        assert(capacity > 0)
        buckets = Array<Bucket>(repeatElement([], count: capacity))
    }
    
    private func index(forKey key: Key) -> Int {
        return abs(key.hashValue % buckets.count)
    }
    
    // Basic operations for a HashTable
    // 1. Inserting a key value pair
    // 2. Retrieving a value
    // 3. Updating a value
    // 4. Removing a value for key
    
    public subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        set {
            
        }
    }
    
    // 2.
    public func value(forKey key: Key) -> Value? {
        let index = self.index(forKey: key)
        for element in buckets[index] {
            if element.key == key {
                return element.value
            }
        }
        return nil // key not in hash table
    }
    
    // 1 & 3
    public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
        let index = self.index(forKey: key)
        
        // Checking to see if the key exists and updating it if so
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                let oldValue = element.value
                buckets[index][i].value = value
                return oldValue
            }
        }
        
        // Otherwise we go ahead and add the value to our hash table
        buckets[index].append((key: key, value: value))
        count += 1
        return nil
        
    }
    
    // 4.
    public mutating func removeValue(forKey key: Key) -> Value? {
        let index = self.index(forKey: key)
        
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                buckets.remove(at: i)
                count -= 1
                return element.value
            }
        }
        
        return nil // key not in hash table
    }
    
}

var hashTable = HashTable<String, String>(capacity: 5)


