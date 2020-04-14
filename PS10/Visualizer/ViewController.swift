//
//  ViewController.swift
//  Visualizer
//
//  Created by Mateo Larrea Ferro on 4/7/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var spectroscope: Spectroscope!
    var synth:Synth = Synth()
    var timer: Timer!
    
       override func viewDidLoad() {
            super.viewDidLoad()
            
            timer = Timer.scheduledTimer(timeInterval: 1/60, target: self, selector: #selector(update), userInfo: nil, repeats: true)
            
            let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            spectroscope.addGestureRecognizer(pan)
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            checkForHeadphones()
        }
        
        @objc func update(){
            spectroscope.setSpectrum(spectrum: synth.getFFT())
        }

        @objc func handlePan(_ recognizer: UIPanGestureRecognizer){
            let loc = recognizer.location(in: spectroscope)
            
            if(spectroscope.bounds.contains(loc)){
                spectroscope.drawCircle(point: loc)
                let xloc = Float(loc.x/spectroscope.frame.width)
                let yloc = Float((1.0 - (loc.y/spectroscope.frame.height)))

                synth.setFrequency(freq: xloc)
                synth.setResonance(res: yloc)
            }
        }
        
        // Warn user about feedback if headphones are not connected
        func checkForHeadphones() {
            let isHeadphoneConnected = headphonesPlugged()
            
            if !isHeadphoneConnected {
                let alert = UIAlertController(title:"Feedback Warning!", message:"Without headphones plugged in, you may experience feedback!", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title:"OK", style: .default, handler: nil)
                alert.addAction(defaultAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        // Return a BOOL signifying whether or not headphones are connected to the current device
        func headphonesPlugged() -> Bool {
            let availableOutputs = AVAudioSession.sharedInstance().currentRoute.outputs
            for out in availableOutputs {
                if out.portType == AVAudioSession.Port.headphones {
                    return true
                }
            }
            return false
        }
    }
