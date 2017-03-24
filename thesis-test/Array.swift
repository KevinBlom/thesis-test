//
//  Array.swift
//  thesis-test
//
//  Created by Kevin Blom on 24/03/2017.
//  Copyright © 2017 Kevin Blom. All rights reserved.
//

import Foundation

extension Array {
    mutating func randomItemDestructive() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        let tempElement = self[index]
        self.remove(at: index)
        print(self.count)
        return tempElement
    }
}
