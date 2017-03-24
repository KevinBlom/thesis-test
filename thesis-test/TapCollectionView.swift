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
    
    var tapStartTime: UInt64 = 0
    var tapEndTime: UInt64 = 0
    
    var tapDuration: UInt64 {
        get {
            let elapsed = tapEndTime - tapStartTime
            var timeBaseInfo = mach_timebase_info_data_t()
            mach_timebase_info(&timeBaseInfo)
            return elapsed * UInt64(timeBaseInfo.numer) / UInt64(timeBaseInfo.denom);
        }
    }
    
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
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tapStartTime = mach_absolute_time()
        super.touchesBegan(touches, with: event)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                // 3D Touch capable
                let force = touch.force
                print("Force: " + force.description)
                bufferTap.add(force: force)
                tapEndTime = mach_absolute_time()
            }
        }
        super.touchesMoved(touches, with: event)
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
        indicesForTappableCells = []
        randomIndexPickerList = []
        
        generateRandomTappableCells()
        
        for index in 0...indicesForTappableCells.count-1 {
            if let cell = cellForItem(at: [0,indicesForTappableCells[index]]) {
                cell.backgroundColor = UIColor.cyan
            }
        }
    }
    
    func taps() -> Int {
        return tapSeries.count
    }
}
