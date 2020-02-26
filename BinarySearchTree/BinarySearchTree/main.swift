//
//  BinarySearchTree
//
//  Created by Andrei Blaj on 2/25/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import Foundation

var tree: BinaryNode<Int> {
    let zero = BinaryNode(value: 0)
    let one = BinaryNode(value: 1)
    let five = BinaryNode(value: 5)
    let seven = BinaryNode(value: 7)
    let eight = BinaryNode(value: 8)
    let nine = BinaryNode(value: 9)
    
    seven.leftChild = one
    one.leftChild = zero
    one.rightChild = five
    
    seven.rightChild = nine
    nine.leftChild = eight
    
    return seven
}

tree.traverseInOrder { print($0) }
