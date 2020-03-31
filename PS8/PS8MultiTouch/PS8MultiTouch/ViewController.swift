//
//  ViewController.swift
//  PS8MultiTouch
//
//  Created by Mateo Larrea Ferro on 3/30/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Store Touches
    //Key is Integer. This is de id of each finger.
    //CGPoint is where the finger is on the screen.
    var fingers = [Int: CGPoint]()
    let synth = Synth()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // 4 main Functions for Touch: touchesBegan, touchesMoved, touchesEnded, and touchesCancelled

}

extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if fingers[touch.hash] == nil {
                var point  = touch.location(in: self.view)
                (self.view as! MultiTouchView).addCircle(point: point) //downgrade UIView into MultiTouchView
                //Scale the rage (0 - 1)
                point.x = point.x/view.frame.size.width
                point.y = point.y/view.frame.size.height
                //store touch position in dictionary using their ID
                fingers[touch.hash] = point
                //Update sYNTH
                synth.update(id: touch.hash, point: point) //essential
                print("comenzo esta huevada!!")
            }
            
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if fingers[touch.hash] != nil {
                // Update location of touch
                var point = touch.location(in: self.view)
                (self.view as! MultiTouchView).addCircle(point: point)
                //Scale the range
                point.x = point.x / view.frame.size.width
                point.y = point.y / view.frame.size.height
                //Store nuew position
                fingers[touch.hash] = point
                //Update sYNTH
                synth.update(id: touch.hash, point: point) //essential
                print("date!!!")
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            // Does the touch exist in the dictionary?
            if fingers[touch.hash] != nil {
                synth.stop(id: touch.hash)
                fingers.removeValue(forKey: touch.hash)
               
            }
                 print("Touch Ended :( ")
            
        }
            //remove all circles
            if fingers.count <= 0 { //no more fingers?
                for subview in self.view.subviews {
                    subview.removeFromSuperview()
                }
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
           // Does the touch exist in the dictionary?
                     if fingers[touch.hash] != nil {
                         fingers.removeValue(forKey: touch.hash)
                        synth.stop(id: touch.hash)
                        print("Touch Cancelled")
            }
        }
        //remove all circles
               if fingers.count <= 0 { //no more fingers?
                   for subview in self.view.subviews {
                       subview.removeFromSuperview()
                   }
           }
    }
}
