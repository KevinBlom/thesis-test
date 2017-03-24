//
//  Constants.swift
//  thesis-test
//
//  Created by Kevin Blom on 10/02/2017.
//  Copyright © 2017 Kevin Blom. All rights reserved.
//

import Foundation

struct Constants {
    static let maximumTapCount = 4
    static let maximumPhotoCount = 1
    static let gridItems = 16
    static let amountOfTappableCells = 4
    static let nextPhotoDelay = 1.0
    
    // Folder names in asset catalog
    static let pictureRootFolderPath = "/Pictures"
    static let animalFolderName = "Animal"
    static let humanFolderName = "Human"
    static let neutralFolderName = "Neutral"
    static let positiveFolderName = "Positive"
    static let spiderFolderName = "Spider"
    static let snakeFolderName = "Snake"
    
    // Prefix of pictures in corresponding folders
    static let animalImageNamePrefix = "A"
    static let humanImageNamePrefix = "H"
    static let neutralImageNamePrefix = "N"
    static let positiveImageNamePrefix = "P"
    static let spiderImageNamePrefix = "Sp"
    static let snakeImageNamePrefix = "Sn"
    
    // Images are PNG format, if it changes -> this is the place
    static let imageExtensionSuffix = ".png"
    
}
