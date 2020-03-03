//
//  XYPad.swift
//  NavProcessor
//
//  Created by Mateo Larrea Ferro on 2/25/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.
//

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
