//
//  TapCollectionView.swift
//  thesis-test
//
//  Created by Kevin Blom on 09/03/2017.
//  Copyright © 2017 Kevin Blom. All rights reserved.
//

import Foundation
import UIKit

class TapCollectionView: UICollectionView {
    
    var randomIndexPickerList: [Int]
    
    var indicesForTappableCells: [Int]
    
    let reuseIdentifier = "cell"
    
    required init?(coder aDecoder: NSCoder) {
        randomIndexPickerList = []
        indicesForTappableCells = []
        
        super.init(coder: aDecoder)
        
        generateRandomTappableCells()
        
    }
    
    func refreshTappableCells() {
        generateRandomTappableCells()
    }
    
    func generateRandomTappableCells() {
        for index in 0...Constants.gridItems {
            randomIndexPickerList.append(index)
        }

        for _ in 1...Constants.amountOfTappableCells {
            let pickIndex = arc4random_uniform(UInt32(randomIndexPickerList.count))
            indicesForTappableCells.append(randomIndexPickerList[Int(pickIndex)])
            randomIndexPickerList.remove(at: Int(pickIndex))
        }
        print(indicesForTappableCells)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }
}
