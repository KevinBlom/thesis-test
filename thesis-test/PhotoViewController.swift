//
//  PhotoViewController.swift
//  thesis-test
//
//  Created by Kevin Blom on 10/02/2017.
//  Copyright © 2017 Kevin Blom. All rights reserved.
//

import UIKit
import Firebase
import CoreGraphics

class PhotoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var databaseReference: FIRDatabaseReference!
    var experimentKey: String!
    
    var recordTouches: Bool = true
    
    var photoCounter: Int = 0
    var tapCounter: Int = 0
    
    var tapSeries:[Tap] = [Tap(), Tap(), Tap(), Tap()]
    
    var photoSet: PhotoSet = PhotoSet(imagesWithPrefix: "P0", startOn: 44)
    
    let reuseIdentifier = "cell"
    
    @IBOutlet weak var tapCollectionView: TapCollectionView!
    @IBOutlet weak var photoView: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        photoView.image = photoSet.currentImage
        tapCollectionView.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Constants.nextPhotoDelay) {
            self.tapCollectionView.isHidden = false
        }
    }
    

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                // 3D Touch capable
                let force = touch.force
                print("Force: " + force.description)
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
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.gridItems
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cv = collectionView as! TapCollectionView
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath)
        
        if(cv.indicesForTappableCells.contains(indexPath[1])) {
            cell.backgroundColor = UIColor.cyan // make cell more visible in our example project

        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        recordTouches = false
    }
}
