import Foundation

class TrieNode<T: Hashable> {
    
    var value: T?
    weak var parentNode: TrieNode?
    var children: [T: TrieNode] = [:]
    var isTerminating = false
    var isLeaf: Bool {
        return children.count == 0
    }
    
    init(value: T? = nil, parentNode: TrieNode? = nil) {
        self.value = value
        self.parentNode = parentNode
    }
    
    func addChild(value: T) {
        guard children[value] == nil else {
            return
        }
        children[value] = TrieNode(value: value, parentNode: self)
    }
    
}
