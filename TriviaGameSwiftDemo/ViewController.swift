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
    @IBOutlet weak var next: UIButton!
    
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    
    var score: Int = 0
    var allEntries: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
    }

}











