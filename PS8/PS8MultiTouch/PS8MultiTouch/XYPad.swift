//
//  XYPad.swift
//  PS8MultiTouch
//
//  Created by Mateo Larrea Ferro on 3/31/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.

import UIKit

class XYPad: UIView {

    
    var circle = UIView()
    var size:CGFloat = 50
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        drawCircle(CGPoint(x:frame.width*0.5, y:frame.height*0.5))
    }
    
    func drawCircle(_ locationOfTouch: CGPoint){
        clipsToBounds = true //Don't go beyond the parents
        circle.removeFromSuperview() //Remove previous circle-->Update Function
        circle = UIView(frame: CGRect(x: locationOfTouch.x - size/2, y: locationOfTouch.y - size/2, width: size, height: size))
        
        circle.backgroundColor = UIColor.cyan
        circle.alpha = 0.5
        circle.layer.cornerRadius = size/2 //make it into circle
        circle.clipsToBounds = true
        addSubview(circle)
    }

}


/*import UIKit

class MultiTouchView: UIView {

    let circleSize: CGFloat = 50
    var color: CGFloat = 0
    
    // Automatically called by Main.storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder) //This is a must becasue of requires keyword
        clipsToBounds = true
    }
    
    func addCircle(point: CGPoint) { //Incoming point is our touch
        let circle = UIView(frame: CGRect (x: point.x - circleSize/2 , y: point.y - circleSize/2, width: circleSize, height: circleSize))
        
        circle.alpha = 0.5
        circle.backgroundColor = UIColor(hue: color, saturation: 1, brightness: 1, alpha: 1)
        color += 0.01 //the rate = how fast the color changes
        if color >= 1 {
            color -= 1.0
        }
        
        circle.layer.cornerRadius = circleSize / 2 //Use cornerRadius to change into circle
        //without this code IU View would have a sharp corner by default --> the smaller it is the closer it gets to sharp corner
        self.addSubview(circle)
    }
}
    
*/


