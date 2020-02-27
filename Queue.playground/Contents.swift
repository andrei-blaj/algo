public struct Queue<T> {
    
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.count == 0
    }
    
    public var count: Int {
        return array.count
    }
    
    public var front: T? {
        return array.first
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        }
        return array.removeFirst()
    }
    
}
