public struct Stack<T> {
    
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.count == 0
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        if isEmpty {
            return nil
        }
        return array.popLast()
    }
    
    public var top: T? {
        return array.last
    }
    
}
