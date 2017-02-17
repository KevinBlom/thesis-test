//
//  PhotoViewController.swift
//  thesis-test
//
//  Created by Kevin Blom on 10/02/2017.
//  Copyright © 2017 Kevin Blom. All rights reserved.
//

import UIKit
import Firebase

class PhotoViewController: UIViewController {
    
    var databaseReference: FIRDatabaseReference!
    var experimentKey: String!
    
    var recordTouches: Bool = true
    
    var photoCounter: Int = 0
    var tapCounter: Int = 0
    
    var tapSeries:[Tap] = [Tap(), Tap(), Tap(), Tap()]

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                // 3D Touch capable
                let force = touch.force
                tapSeries[tapCounter].addTap(force: force)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        if(recordTouches){
            self.databaseReference.child("experiments").child(experimentKey).child(String(photoCounter)).child(String(tapCounter)).setValue(tapSeries[tapCounter].forceSeries)
            tapCounter += 1
            if tapCounter > Constants.maximumTapCount-1 {
                tapCounter = 0
                photoCounter += 1
            }
            
            if photoCounter > Constants.maximumPhotoCount-1 {
                DispatchQueue.main.async(execute: {
                    self.performSegue(withIdentifier: "experimentConcluded", sender: self)
                })
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        recordTouches = false
    }
}
