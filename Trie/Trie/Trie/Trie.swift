//
//  Trie.swift
//  Trie
//
//  Created by Andrei Blaj on 3/10/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import Foundation

class Trie: NSObject, NSCoding {

    typealias Node = TrieNode<Character>
    
    fileprivate let root: Node
    fileprivate var wordCount = 0
    
    // Number of words in a Trie
    public var count: Int {
        return wordCount
    }
    
    public var isEmpty: Bool {
        return wordCount == 0
    }
    
    public var words: [String] = []
    
    // Create an empty Trie
    override init() {
        root = Node()
        wordCount = 0
        super.init()
    }
    
    func encode(with coder: NSCoder) {
        
    }
    
    required convenience init?(coder decoder: NSCoder) {
        self.init()
        let words = decoder.decodeObject(forKey: "words") as? [String]
        for word in words! {
            self.insert(word: word)
        }
    }
    
}

// Insert, Remove, Contains
extension Trie {
    
    func insert(word: String) {
        guard !word.isEmpty else {
            return
        }
        
        var currentNode = root
        
        for character in word.lowercased() {
            if let childNode = currentNode.children[character] {
                currentNode = childNode
            } else {
                currentNode.addChild(value: character)
                currentNode = currentNode.children[character]!
            }
        }
        
        guard !currentNode.isTerminating else {
            return
        }
        
        wordCount += 1
        currentNode.isTerminating = true
        
    }
    
    func contains(word: String) -> Bool {
    
        guard !word.isEmpty else {
            return false
        }
        
        var currentNode = root
        
        for character in word.lowercased() {
            guard let childNode = currentNode.children[character] else {
                return false
            }
            currentNode = childNode
        }
        
        return currentNode.isTerminating
    }
    
    private func findLastNodeOf(word: String) -> Node? {
        var currentNode = root
        
        for character in word.lowercased() {
            guard let childNode = currentNode.children[character] else {
                return nil
            }
            currentNode = childNode
        }
        
        return currentNode
    }
    
    private func findTerminalNodeOf(word: String) -> Node? {
        if let lastNode = findLastNodeOf(word: word) {
            return lastNode.isTerminating ? lastNode : nil
        }
        return nil
    }
    
    private func deleteNodesForWordEndingWith(terminalNode: Node) {
        var lastNode = terminalNode
        var character = lastNode.value
        
        while lastNode.isLeaf, let parentNode = lastNode.parentNode {
            lastNode = parentNode
            lastNode.children[character!] = nil
            character = lastNode.value
            
            if lastNode.isTerminating {
                break
            }
        }
    }
    
    func remove(word: String) {
        guard !word.isEmpty else {
            return
        }
        
        guard let terminalNode = findTerminalNodeOf(word: word) else {
            return
        }
        
        if terminalNode.isLeaf {
            deleteNodesForWordEndingWith(terminalNode: terminalNode)
        } else {
            terminalNode.isTerminating = false
        }
        
        wordCount -= 1
    }
    
    fileprivate func wordsInSubtrie(rootNode: Node, partialWord: String) -> [String] {
        var subtrieWords = [String]()
        var previousLetters = partialWord
        
        if let value = rootNode.value {
            previousLetters.append(value)
        }
        
        if rootNode.isTerminating {
            subtrieWords.append(previousLetters)
        }
        
        for childNode in rootNode.children.values {
            let childWords = wordsInSubtrie(rootNode: childNode, partialWord: previousLetters)
            subtrieWords += childWords
        }
        
        return subtrieWords
    }
    
    func findWordsWithPrefix(prefix: String) -> [String] {
        var words = [String]()
        let prefixLowerCased = prefix.lowercased()
        
        if let lastNode = findLastNodeOf(word: prefixLowerCased) {
            if lastNode.isTerminating {
                words.append(prefixLowerCased)
            }
            for childNode in lastNode.children.values {
                let childWords = wordsInSubtrie(rootNode: childNode, partialWord: prefixLowerCased)
                words += childWords
            }
        }
        
        return words
    }
    
}
