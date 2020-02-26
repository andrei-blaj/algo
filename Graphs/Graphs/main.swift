//
//  main.swift
//  Graphs
//
//  Created by Andrei Blaj on 2/26/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import Foundation

func readData(from path: String) -> String {
    do {
        let data = try NSString(contentsOfFile: path, encoding: String.Encoding.ascii.rawValue)
        return String(data)
    } catch {
        return ""
    }
}

//labirintProblem()
museumProblem()
