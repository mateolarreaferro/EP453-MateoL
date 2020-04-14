//
//  Spectroscope.swift
//  Visualizer
//
//  Created by Mateo Larrea Ferro on 4/7/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.
//

import UIKit

import UIKit

class Spectroscope: UIView {

    var spectrum:[Double] = []
    var initialized = false
    
    var circle = UIView()
    var circleSize:CGFloat = 50
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.clipsToBounds = true
    }
    
    func setSpectrum(spectrum:[Double]){
        self.spectrum = spectrum
        if(!initialized){
            initialized = true
        }
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!

        //Fill the view with black color
        context.setFillColor(red: 0, green: 0, blue: 0, alpha: 1)
        context.fill(rect)

        if(!initialized) {return}

        //get bar position
        context.setFillColor(red: 1, green: 1, blue: 1, alpha: 1)
        let xUnit = rect.size.width / CGFloat(spectrum.count)
        let height = rect.size.height

        //Draw bars for viewing spectrum
        for i in 0..<spectrum.count {
            let y = CGFloat(spectrum[Int(i)])
            let fillRect = CGRect(x: xUnit * CGFloat(i), y: height, width: xUnit, height: -height * y)
            context.fill(fillRect)
        }
    }
    
    func drawCircle(point: CGPoint){
        circle.removeFromSuperview()
        circle = UIView(frame: CGRect(x: point.x - circleSize/2, y: point.y - circleSize/2, width: circleSize, height: circleSize))
        circle.backgroundColor = UIColor.white
        circle.alpha = 0.5
        circle.layer.cornerRadius = circleSize/2
        circle.clipsToBounds = true
        self.addSubview(circle)
    }
}
