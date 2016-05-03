//
//  DragImg.swift
//  MyMonster
//
//  Created by MiciH on 5/3/16.
//  Copyright © 2016 MicahelH. All rights reserved.
//

import Foundation
import UIKit

class DragImg: UIImageView {
    
    var orignalPointion: CGPoint!
    var dropTraget: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        orignalPointion = self.center
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first{
            //where the user touch on the screen
            let postion = touch.locationInView(self.superview)
            //center image to user touch
            self.center = CGPointMake(postion.x, postion.y)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first, let target = dropTraget {
            //where the user touch on the screen
                let postion = touch.locationInView(self.superview)
            //if the touch is within the image
            if CGRectContainsPoint(target.frame, postion){
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "onTragetDropped", object: nil))
            }
            
        }
        
        self.center = orignalPointion
    }
    
}
