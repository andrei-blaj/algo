//
//  BST.swift
//  BinarySearchTree
//
//  Created by Andrei Blaj on 2/25/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import Foundation

public struct BinarySearchTree<Element: Comparable> {
    public private(set) var root: BinaryNode<Element>?
    
    public init() {}
}

extension BinarySearchTree {
    
    public mutating func insert(_ value: Element) {
        
    }
    
    private func insert(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element> {
        // 1
        guard let node = node else {
            return BinaryNode(value: value)
        }
        
        // 2
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        
        // 3
        return node
    }
    
}
