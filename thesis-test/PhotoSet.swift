//
//  PhotoSet.swift
//  thesis-test
//
//  Created by Kevin Blom on 23/02/2017.
//  Copyright © 2017 Kevin Blom. All rights reserved.
//

import Foundation
import UIKit

class PhotoSet{
    
    var prefix: String
    var startIndex: Int
    var endIndex: Int
    var currentIndex: Int
    var currentImage: UIImage {
        get {
            return UIImage(named: currentImageName)!
        }
    }
    
    var nextImage: UIImage {
        get {
            return UIImage(named: nextImageName)!
        }
    }

    var currentImageName: String {
        get {
            var imageName: String = prefix
            imageName += String(currentIndex)
            return imageName
        }
    }
    
    var nextImageName: String {
        get {
            currentIndex += 1
            if (currentIndex > endIndex) {
                currentIndex -= 1
            }
            var imageName: String = prefix
            imageName += String(currentIndex)
            return imageName
        }
    }
    
    var lastPhoto: Bool {
        get {
            return currentIndex == endIndex
        }
    }
    
    init(imagesWithPrefix prefix: String, startAt startIndex: Int, endAt endIndex: Int){
        self.prefix = prefix
        self.startIndex = startIndex
        self.endIndex = endIndex
        self.currentIndex = startIndex
    }
    
    
}
