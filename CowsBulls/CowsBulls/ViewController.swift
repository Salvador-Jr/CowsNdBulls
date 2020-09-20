//
//  ViewController.swift
//  CowsBulls
//
//  Created by Salvador Rodriguez on 9/19/20.
//  Copyright © 2020 Salvador Rodriguez. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    
    @IBOutlet var tableView: NSTableView!
    @IBOutlet var Guess: NSTextField!
    var answer = ""
    var guesses = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func submitGuess(_ sender: Any) {
        let guessStringValue = Guess.stringValue
        guard Set(guessStringValue).count == 4 else{return}
        let badCharacters = CharacterSet(charactersIn: "0123456789").inverted //anything outside of this character set is put into BC
        guard guessStringValue.rangeOfCharacter(from: badCharacters) == nil else{return}
        
        guesses.insert(guessStringValue, at:0)
        tableView.insertRows(at: IndexSet(integer: 0), withAnimation: .slideDown)
        let resultString = result(for: guessStringValue)
        if resultString.contains("4b"){
            let alert = NSAlert()
            alert.messageText = "You Win"
            alert.informativeText = "Congratulations! Click ok to play again."
            alert.runModal()
            startNewGame()
        }
    }
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        
        return guesses.count
    }
    
    func result(for guess: String)->String{
        var bulls = 0
        var cows = 0
        
        let guessLetters = Array(guess)
        let answerLetters = Array(answer)
        for (index, letter) in guessLetters.enumerated(){
            if letter == answerLetters[index]{
                bulls += 1
            }
            else if answerLetters.contains(letter){
                cows += 1
            }
        }
        
        return "\(bulls)b \(cows)c"
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self)as? NSTableCellView else {
            return nil
        }
        if tableColumn?.title == "Guess"{
            vw.textField?.stringValue = guesses[row]
        }
        else{
            vw.textField?.stringValue = result(for: guesses[row])
        }
        return vw
    }
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
    
    func startNewGame(){
        Guess.stringValue = ""
        guesses.removeAll()
        var numbers = Array(0...9)
        numbers.shuffle()
        for _ in 0 ..< 4{
            answer.append(String(numbers.removeLast()))
        }
        tableView.reloadData()
    }
   
}

