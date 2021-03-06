//
//  ViewController.swift
//  MyMonster
//
//  Created by MiciH on 5/3/16.
//  Copyright © 2016 MicahelH. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet var monsterImg: MonsterImage!
    
    @IBOutlet var loveImg: DragImg!
    
    @IBOutlet var foodImg: DragImg!

    @IBOutlet weak var penlty1: UIImageView!
    
    @IBOutlet weak var penlty2: UIImageView!
    
    @IBOutlet weak var penlty3: UIImageView!
    
     @IBOutlet weak var restart: UIButton!
    
    let DIM_ALPHA : CGFloat = 0.2
    let NO_ALPHA : CGFloat = 1.0
    let MAX_PENLATIES = 3
    
    var penalites = 0
    
    var timer : NSTimer!
    var monsterHappy : Bool = false
    
    var currentLoveOrFood : UInt32 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImg.dropTraget = monsterImg
        loveImg.dropTraget = monsterImg
        
        penlty1.alpha = DIM_ALPHA
        penlty2.alpha = DIM_ALPHA
        penlty3.alpha = DIM_ALPHA
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTragetDropped", object: nil)
        
    startTimer()
        
    }
    
    func itemDroppedOnCharacter(nofit: AnyObject){
//        print("ITEM DROPPED ON CHAR")
        
        monsterHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        
        loveImg.alpha = DIM_ALPHA
        loveImg.userInteractionEnabled = false

    }
    
    func startTimer(){
        
        
        if timer != nil{
            timer.invalidate()
        }
     timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "PentalyTime", userInfo: nil, repeats: true)
    }
    
    func PentalyTime() {
        
        
        if !monsterHappy {
            penalites++
            
            if penalites == 1{
                penlty1.alpha = NO_ALPHA
                penlty2.alpha = DIM_ALPHA
            }
            else if penalites == 2{
                penlty2.alpha = NO_ALPHA
                 penlty3.alpha = DIM_ALPHA
            }
            else if penalites == 3{
                penlty3.alpha = NO_ALPHA
            }
            else {
                 penlty1.alpha = DIM_ALPHA
                 penlty2.alpha = DIM_ALPHA
                 penlty3.alpha = DIM_ALPHA
            }
            
            if penalites >= MAX_PENLATIES{
                gameOver()
            }

        }
        
        let rand = arc4random_uniform(2)
        
        if rand == 0{
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            
            loveImg.alpha = NO_ALPHA
            loveImg.userInteractionEnabled = true
        }
        else{
            loveImg.alpha = DIM_ALPHA
            loveImg.userInteractionEnabled = false
            
            foodImg.alpha = NO_ALPHA
            foodImg.userInteractionEnabled = true
        }
        currentLoveOrFood = rand
        monsterHappy = false
        
        
    }
    
    func gameOver(){
        timer.invalidate()
        monsterImg.MonsterDeadAniamtion()
        
        restart.hidden = false
        
    }

    @IBAction func restartAction(sender: AnyObject) {
        startTimer()
        
        restart.hidden = true
        
        monsterImg.MonsterBreatheAniamtion()
        penalites = 0
        
        penlty1.alpha = DIM_ALPHA
        penlty2.alpha = DIM_ALPHA
        penlty3.alpha = DIM_ALPHA
        
        monsterHappy = false
        
        
    
    }
   
}

