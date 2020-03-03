//
//  PS5.swift
//  NavProcessor
//
//  Created by Mateo Larrea Ferro on 3/3/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.
//

import UIKit
import AudioKit

class PS5: UIView {

    @IBOutlet var xyPad: XYPad!
    //Declaration of elements
    var filter:AKStringResonator?
    var filter:AKChorus

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //node
        override func viewDidAppear(_ animated: Bool) {
        AKSettings.sampleRate = AudioKit.engine.inputNode.inputFormat(forBus: 0).sampleRate
        fundamentalFrequency: Double = defaultFundamentalFrequency,
        feedback: Double = defaultFeedback
            
            do{
                try AudioKit.start()
            }
            catch{
                print("Not Starting")
            }

        // Initialize pan gesture recognizer and add it to xyPad
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        xyPad.addGestureRecognizer(pan)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let mic = AKMicrophone()
        filter = AKStringResonator(mic)
        AudioKit.output = filter
        do{
            try AudioKit.start()
        }
        catch{
            print("Cannot start AudioKit")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        do{
            try AudioKit.stop()
        }
        catch{
            print("Cannot stop AudioKit")
        }
    }
    // Handle pan gesture
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        // Draw circle to follow finger during pan gesture in XYPad
        let loc = recognizer.location(in: xyPad)
    
        // Ensure panning is only used to draw circle and update xloc and yloc if it does not stray outside the XYPad
        if xyPad.bounds.contains(loc) {
            xyPad.drawCircle(loc)
            let xloc = Float(loc.x/xyPad.frame.width)
            let yloc = Float((1.0 - (loc.y/xyPad.frame.height)))
            filter?.AKStringResonator = xloc * 10000
            filter?.resonance = yloc * 60 - 20
        }
    }
}
