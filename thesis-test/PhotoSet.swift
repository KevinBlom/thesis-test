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
    
    var imageURLs: [URL]
    var currentImageName: String
    
    init(fromFolder named: String, withExtension format: String){
        imageURLs = []
        currentImageName = ""
        imageURLs = loadImageURLs()
    }
    
    func loadImageURLs() -> [URL] {
        var tempURLs: [URL] = []
        
        if let path = Bundle.main.resourcePath {
            let imagePath = path + Constants.pictureRootFolderPath
            let url = URL(fileURLWithPath: imagePath)
            let fileManager = FileManager.default
            
            let properties = [URLResourceKey.localizedNameKey,
                              URLResourceKey.creationDateKey, URLResourceKey.localizedTypeDescriptionKey]
            
            do {
                tempURLs = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: properties, options:FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
                
                print("image URLs: \(tempURLs)")
                // Create image from URL
                //var myImage =  UIImage(data: NSData(contentsOfURL: imageURLs[0])!)
                
            } catch let error as NSError {
                print(error.description)
            }
        }
        
        return tempURLs
    }
    
    func nextImage() -> UIImage {
        var imageData: Data
        let tempURL = randomImageURL()
        currentImageName = tempURL.lastPathComponent
        
        do {
            imageData = try Data(contentsOf: tempURL)
        } catch let error as NSError {
            print(error.description)
            return UIImage()
        }
        
        return UIImage(data: imageData)!
    }
    
    func randomImageURL () -> URL {
        return imageURLs.randomItemDestructive() as URL
    }
    
    func imagesLeft() -> Bool {
        return imageURLs.count > 0
    }
}
