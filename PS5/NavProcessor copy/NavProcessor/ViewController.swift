//
//  ViewController.swift
//  NavProcessor
//
//  Created by Mateo Larrea Ferro on 2/25/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    @IBOutlet weak var volSlider: UISlider!
    @IBOutlet weak var distSlider: UISlider!
    @IBOutlet weak var revSlider: UISlider!
    
    var booster: AKBooster?
    var decimator: AKDecimator?
    var reverb: AKReverb?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
    AKSettings.sampleRate = AudioKit.engine.inputNode.inputFormat(forBus: 0).sampleRate
    let mic = AKMicrophone()
    decimator = AKDecimator(mic)
    decimator?.decimation = 0.5
    decimator?.rounding = 0.5
    decimator?.mix = 0.5
    reverb = AKReverb (decimator)
    reverb?.dryWetMix = 0.5
    booster = AKBooster (reverb)
    booster?.gain = 0.5
    AudioKit.output = booster
        do{
            try AudioKit.start()
        }
        catch{
            print("Not Starting")
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
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        switch sender {
        case volSlider: booster?.gain = Double(sender.value)
        case distSlider: decimator?.decimation = Double(sender.value)
        case revSlider: reverb?.dryWetMix = Double(sender.value)
        default: break
        }
    }
    
}

