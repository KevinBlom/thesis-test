//
//  Tap.swift
//  thesis-test
//
//  Created by Kevin Blom on 10/02/2017.
//  Copyright © 2017 Kevin Blom. All rights reserved.
//

import UIKit
import Foundation

class Tap {
    var forceSeries:[CGFloat] = []
    
    init() {
        
    }
    
    func add(force: CGFloat) {
        forceSeries.append(force)
    }
}
