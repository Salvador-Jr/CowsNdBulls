//
//  ViewController.swift
//  CowsBulls
//
//  Created by Salvador Rodriguez on 9/19/20.
//  Copyright © 2020 Salvador Rodriguez. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    
    @IBOutlet var tableView: NSTableView!
    @IBOutlet var Guess: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func submitGuess(_ sender: Any) {
    }
    
}

