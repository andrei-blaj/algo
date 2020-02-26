//
//  Queue.swift
//  Graphs
//
//  Created by Andrei Blaj on 2/26/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import Foundation

struct Queue<Element> {
    
    var items: [Element]
    
    mutating func push(_ value: Element) {
        items.append(value)
    }
    
    mutating func pop() -> Element? {
        
        if self.isEmpty() {
            return nil
        }
        
        let value = items.first
        items.remove(at: 0)
        return value
    }
    
    func isEmpty() -> Bool {
        return items.count == 0
    }
    
}
