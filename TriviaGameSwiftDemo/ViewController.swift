//
//  ViewController.swift
//  TriviaGameSwiftDemo
//
//  Created by User on 10/19/15.
//  Copyright © 2015 Elijah Buters. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    
    var score: Int = 0
    var allEntries: NSArray!
    var currentCorrectAnswerIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let randomNumber = Int(arc4random_uniform(UInt32(allEntries.count)))
        
        loadScore()
        loadAllQuestionsAndAnswers()
        loadQuestion(1)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadScore() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        score = defaults.integerForKey("score")
        labelScore.text = "score: \(score)"
    }
    
    func saveScore() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(score, forKey: "score")
    }

    
    func loadAllQuestionsAndAnswers() {
        
        
        let path = NSBundle.mainBundle().pathForResource("content", ofType: "json")
        let jsonData: NSData = NSData(contentsOfFile: path!)!
        
        do {
            
            allEntries = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSArray
        } catch {
            print(allEntries)
        }
        print(allEntries)
    }
    
    func loadQuestion(index: Int) {
        
        let entry :NSDictionary = allEntries.objectAtIndex(index) as! NSDictionary
        let question: NSString = entry.objectForKey("question") as! NSString
        let arr: NSMutableArray = entry.objectForKey("answers") as! NSMutableArray
        
        print(question)
        print(arr)
        
        labelQuestion.text = question as String
        
        let indices: [Int] = [0, 1, 2, 3]
        let newSequence = shuffle(indices)
        var i: Int = 0
        for (i = 0; i < newSequence.count; i++) {
            
            let index = newSequence[i]
            if (index == 0) {
                
                //we need to store the correct answer index
                currentCorrectAnswerIndex = i
            }
            
            
            let answer = arr.objectAtIndex(index) as! NSString
            switch(i) {
                
            case 0:
                buttonA.setTitle(answer as String, forState: UIControlState.Normal) //Swift 2, answer as String
                break;
            case 1:
                buttonB.setTitle(answer as String, forState: UIControlState.Normal) //Swift 2, answer as String
                break;
            case 2:
                buttonC.setTitle(answer as String, forState: UIControlState.Normal) //Swift 2, answer as String
                break;
            case 3:
                buttonD.setTitle(answer as String, forState: UIControlState.Normal) //Swift 2, answer as String
                break;
            default:
                break;
            }
        }
        buttonNext.hidden = true
        //We will need to reset the buttons to reenable them
        resetAnswerButtons()
        
    }
    
    func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
        
        let count = list.count  //Swift2, list.count; newElements() - not working
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i //
            guard i != j else { continue } //Swift2.0, guard i != j else { continue }
            swap(&list[i], &list[j])
        }
        
        return list
            
        }
    
    
    func resetAnswerButtons() {
        
        buttonA.alpha = 1.0
        buttonB.alpha = 1.0
        buttonC.alpha = 1.0
        buttonD.alpha = 1.0
        buttonA.enabled = true
        buttonB.enabled = true
        buttonC.enabled = true
        buttonD.enabled = true
    }
    
}









