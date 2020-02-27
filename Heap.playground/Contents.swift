struct Heap<T> {
    
    var nodes = [T]()
    
    private var orderCriteria: (T, T) -> Bool
    
    public init(sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
    }
    
    public init(array: [T], sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
        configureHeap(from: array)
    }
    
    public var isEmpty: Bool {
        return nodes.count == 0
    }
    
    public var count: Int {
        return nodes.count
    }
    
    private mutating func configureHeap(from array: [T]) {
        nodes = array
        for i in stride(from: nodes.count/2 - 1, to: 0, by: -1) {
            shiftDown(from: i)
        }
    }
    
    func parentIndex(ofIndex i: Int) -> Int {
        return (i - 1) / 2
    }
    
    func leftChildIndex(ofIndex i: Int) -> Int {
        return 2 * i + 1
    }
    
    func rightChildIndex(ofIndex i: Int) -> Int {
        return 2 * i + 2
    }
    
    public func peek() -> T? {
        return nodes.first
    }
    
    public mutating func insert(_ value: T) {
        nodes.append(value)
        // shift up from index: nodes.count - 1
    }
    
    public mutating func replace(valueAtIndex i: Int, with value: T) {
        guard i < nodes.count else { return }
        
        nodes.remove(at: i)
        insert(value)
    }
    
    // Remove top of heap
    mutating func remove() -> T? {
        guard !nodes.isEmpty else { return nil }
        
        if nodes.count == 1 {
            return nodes.removeLast()
        } else {
            let value = nodes[0]
            nodes[0] = nodes.removeLast()
            shiftDown(from: 0)
            return value
        }
    }
    
    mutating func remove(at index: Int) -> T? {
        guard index < nodes.count else { return nil }
        
        let size = nodes.count - 1
        
        if index != size {
            nodes.swapAt(index, size)
            shiftDown(from: index, until: size)
            shiftUp(from: index)
        }
        
        return nodes.removeLast()
    }
    
    mutating func shiftUp(from index: Int) {
        var childIndex = index
        let child = nodes[childIndex]
        var parentIndex = self.parentIndex(ofIndex: index)
        
        while childIndex > 0 && orderCriteria(child, nodes[parentIndex]) {
            nodes[childIndex] = nodes[parentIndex]
            childIndex = parentIndex
            parentIndex = self.parentIndex(ofIndex: childIndex)
        }
        
        nodes[childIndex] = child
    }
    
    mutating func shiftDown(from index: Int, until endIndex: Int) {
        let leftChildIndex = self.leftChildIndex(ofIndex: index)
        let rightChildIndex = leftChildIndex + 1
        
        var nextIndex = index
        
        if leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex], nodes[nextIndex]) {
            nextIndex = leftChildIndex
        }
        
        if rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex], nodes[nextIndex]) {
            nextIndex = rightChildIndex
        }
        
        if nextIndex == index { return }
        
        nodes.swapAt(nextIndex, index)
        shiftDown(from: nextIndex, until: endIndex)
    }
    
    mutating func shiftDown(from index: Int) {
        shiftDown(from: index, until: nodes.count)
    }
    
}
