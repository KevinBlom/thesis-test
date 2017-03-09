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
    
    var photoCounter: Int = 0
    
    var photoSet: PhotoSet = PhotoSet(imagesWithPrefix: "P0", startAt: 44, endAt: 50)
    
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
        
        
        let cv = collectionView as! TapCollectionView
        
        // First: Check if tap is in an active cell, if so, commit the buffered tap, else, clear the buffer
        if(cv.indicesForTappableCells.contains(indexPath.item)) {
            cv.commitTap()
            self.databaseReference.child("experiments").child(experimentKey).child("Photo " + String(photoSet.currentIndex)).child(String(cv.taps())).setValue(cv.tapSeries.last!.forceSeries)
            if let cell = collectionView.cellForItem(at: indexPath as IndexPath) {
                cell.backgroundColor = UIColor.clear
            }
        } else {
            cv.clearBufferTap()
        }
        
        
        
        // Finally: Check if wanted tap amount is reached, move to next picture or end screen
        if (cv.taps() >= Constants.maximumTapCount) {
            cv.resetTapSeries()
            cv.isHidden = true
            
            if photoSet.lastPhoto {
                DispatchQueue.main.async(execute: {
                    self.performSegue(withIdentifier: "experimentConcluded", sender: self)
                })
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Constants.nextPhotoDelay) {
                self.tapCollectionView.isHidden = false
            }
            
            photoView.image = photoSet.nextImage
        }
        
        
    }
}
