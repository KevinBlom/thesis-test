//
//  ViewController.swift
//  thesis-test
//
//  Created by Kevin Blom on 08/02/2017.
//  Copyright © 2017 Kevin Blom. All rights reserved.
//

import UIKit
import Firebase

final class StartController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!

    var connectionReference: FIRDatabaseReference!
    var databaseReference: FIRDatabaseReference!
    var experimentKey: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        connectionReference = FIRDatabase.database().reference(withPath: ".info/connected")
        databaseReference = FIRDatabase.database().reference()
        
        connectionReference.observe(.value, with: { snapshot in
            if let connected = snapshot.value as? Bool, connected {
                self.startButton.isEnabled = connected
            }
        })
        // If there is no connection, do not give the opportunity to start
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startPressed(_ sender: Any) {
        experimentKey = databaseReference.child("experiments").childByAutoId().key
        self.databaseReference.child("experiments").child(experimentKey).child("createdAt").setValue([".sv" : "timestamp"])
        
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "startPressed", sender: self)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startPressed" {
            let destinationPhotoViewController = segue.destination as! PhotoViewController
            destinationPhotoViewController.experimentKey = self.experimentKey
            destinationPhotoViewController.databaseReference = self.databaseReference
        }
    }
}

