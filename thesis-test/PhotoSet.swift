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
    var currentIndex: Int
    var currentImage: UIImage {
        get {
            return UIImage(named: currentImageName)!
            //return UIImage(named: "P044")!
        }
    }
    
    var currentImageName: String {
        get {
            var imageName: String = prefix
            imageName += String(currentIndex)
            //imageName += ".bmp"
            return imageName
        }
    }
    
    init(imagesWithPrefix prefix: String, startOn startIndex: Int){
        self.prefix = prefix
        self.startIndex = startIndex
        self.currentIndex = startIndex
    }
    
}
