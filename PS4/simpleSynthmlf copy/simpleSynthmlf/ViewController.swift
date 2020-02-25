//
//  ViewController.swift
//  simpleSynthmlf
//
//  Created by Mateo Larrea Ferro on 2/11/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI

class ViewController: UIViewController, AKKeyboardDelegate {

    @IBOutlet weak var sawButton: UIButton!
    @IBOutlet weak var sineButton: UIButton!
    @IBOutlet weak var squareButton: UIButton!
    @IBOutlet weak var triangButton: UIButton!
    @IBOutlet weak var keyboardView: UIView!
    @IBOutlet weak var vibratoRate: UISlider!
    @IBOutlet weak var vibratoLenght: UISlider!
    
    let oscillator = AKOscillatorBank(waveform: AKTable(.sine, count: 256))
    //PS4.3 -->Envelopes
   /* let envelope = AKAmplitudeEnvelope(oscillator)
    let envelope;.attackDuration = 0.01
    envelope.decayDuration = 0.1
    envelope.sustainLevel = 0.1
    envelope.releaseDuration = 0.3
    AudioKit.output = envelope
    
    let performance = AKPeriodicFunction(every: 0.5) {
        if (envelope.isStarted) {
            envelope.stop()
        } else {
            envelope.start()
        }
    }
 
    try AudioKit.start(withPeriodicFunctions: performance)
    performance.start()
    oscillator.start()
 *//
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changeWaveform(sineButton)
        
        AudioKit.output = oscillator
        do {
            try AudioKit.start()
        }
        catch {
            print("Failed to start AudioKit.")
        }
        
        setupKeyboard()

    }
    
    @IBAction func changeWaveform(_ sender: UIButton) {
        for button in [sawButton, sineButton, squareButton, triangButton] {
            if button == sender {
                button?.isSelected = true
        }
            else {
                button?.isSelected = false
    }
    
        }
        switch sender {
        case sineButton:
            oscillator.waveform = AKTable(.sine, count: 256)
            case sawButton:
            oscillator.waveform = AKTable(.sawtooth, count: 256)
            case squareButton:
            oscillator.waveform = AKTable(.square, count: 256)
            case triangButton:
            oscillator.waveform = AKTable(.triangle, count: 256)
            //PS4.2 --> UI Sliders
            //case vibratoRate = AKTable(insert vibrato)
            //case vibratoLenght = AKTable (insert vibrato)
        default : break
            
        }
    }

    func setupKeyboard(){
        let screenSize = UIScreen.main.bounds
        
        keyboardView.frame.size.width = screenSize.width
        keyboardView.frame.size.width = screenSize.width/2
        
        let keyboard = AKKeyboardView(width: Int(screenSize.width), height: Int(screenSize.height/2))
        
        keyboard.polyphonicMode = true
        keyboard.delegate = self
        keyboard.octaveCount = 2
        keyboardView.addSubview(keyboard)
    }
    func noteOn(note: MIDINoteNumber) {
        oscillator.play(noteNumber: note, velocity: 127)
    }
    func noteOff(note: MIDINoteNumber) {
         oscillator.stop(noteNumber: note)
        
    }
}

