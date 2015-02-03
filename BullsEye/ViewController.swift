//
//  ViewController.swift
//  BullsEye
//
//  Created by Mário Silva on 30/01/15.
//  Copyright (c) 2015 Mário Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var hitMe: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var startOverBtn: UIButton!
    
    var targetValue: Int = 0
    var currentValue: Int = 50
    var score: Int = 0
    var round: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startNewGame() -> Void {
        score = 0
        round = 0
        startNewRound()
    }
    
    func startNewRound() -> Void {
        round += 1
        targetValue = Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func updateLabels() -> Void {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func summary(difference: Int) -> String {
        var title: String
        if difference == 0 {
            score += 100
            title = "Perfect!"
        } else if difference < 5 {
            score += 50
            title = "You almost had it!"
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        return title
    }
    
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference
        score += points
        
        let message = summary(difference)
        
        let alert = UIAlertController(title: "Bull's Eye", message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "OK", style: .Default, handler: { action in
            self.startNewRound()
            self.updateLabels()
        })
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
    }
    
}

