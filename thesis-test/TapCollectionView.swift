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
    
    
    var tapSeries: [Tap]
    var bufferTap: Tap
    
    required init?(coder aDecoder: NSCoder) {
        randomIndexPickerList = []
        indicesForTappableCells = []
        tapSeries = []
        bufferTap = Tap()
        
        super.init(coder: aDecoder)
        
        generateRandomTappableCells()
        
    }

    func generateRandomTappableCells() {
        
        // Generates an array with increasing numbers to pick random numbers from
        for index in 0...Constants.gridItems-1 {
            randomIndexPickerList.append(index)
        }
        
        for _ in 1...Constants.amountOfTappableCells {
            let pickIndex = arc4random_uniform(UInt32(randomIndexPickerList.count))
            indicesForTappableCells.append(randomIndexPickerList[Int(pickIndex)])
            randomIndexPickerList.remove(at: Int(pickIndex))
        }
        
        print(indicesForTappableCells)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                // 3D Touch capable
                let force = touch.force
                print("Force: " + force.description)
                bufferTap.add(force: force)
            }
        }
    }
    
    func commitTap() {
        tapSeries.append(bufferTap)
        bufferTap = Tap()
    }
    
    func clearBufferTap() {
        bufferTap = Tap()
    }
    
    func resetTapSeries() {
        tapSeries = []
    }
    
    func taps() -> Int {
        return tapSeries.count
    }
}
