//
//  SamplerViewController.swift
//  ProblemSet6MLF
//
//  Created by Mateo Larrea Ferro on 3/10/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.
//

import UIKit
import AudioKit

class SamplerViewController: UIViewController {

    @IBOutlet weak var bdButton: UIButton!
    @IBOutlet weak var sdButton: UIButton!
    @IBOutlet weak var stkButton: UIButton!
    @IBOutlet weak var mtButton: UIButton!
    @IBOutlet weak var ltButton: UIButton!
    @IBOutlet weak var htButton: UIButton!
    @IBOutlet weak var clButton: UIButton!
    @IBOutlet weak var ohhButton: UIButton!
    @IBOutlet weak var chhButton: UIButton!
    
    var mixer:AKMixer?
    var players = [UIButton:AKPlayer]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
            do {
                let bdFile = try AKAudioFile(readFileName: "bass_drum_C1.wav", baseDir: .resources)
                let sdFile = try AKAudioFile(readFileName: "snare_D1.wav", baseDir: .resources)
                let stkFile = try AKAudioFile(readFileName: "cheeb-stick.wav", baseDir: .resources)
                let mtFile = try AKAudioFile(readFileName: "mid_tom_B1.wav", baseDir: .resources)
                let ltFile = try AKAudioFile(readFileName: "lo_tom_F1.wav", baseDir: .resources)
                let htFile = try AKAudioFile(readFileName: "hi_tom_D2.wav", baseDir: .resources)
                let clFile = try AKAudioFile(readFileName: "clap_D#1.wav", baseDir: .resources)
                let ohhFile = try AKAudioFile(readFileName: "open_hi_hat_A#1.wav", baseDir: .resources)
                let chhFile = try AKAudioFile(readFileName: "closed_hi_hat_A#1.wav", baseDir: .resources)
                
                players[bdButton] = AKPlayer(audioFile: bdFile)
                players[bdButton]?.buffering = .always
                players[sdButton] = AKPlayer(audioFile: sdFile)
                players[sdButton]?.buffering = .always
                players[stkButton] = AKPlayer(audioFile: stkFile)
                players[stkButton]?.buffering = .always
                players[mtButton] = AKPlayer(audioFile: mtFile)
                players[mtButton]?.buffering = .always
                players[ltButton] = AKPlayer(audioFile: ltFile)
                players[ltButton]?.buffering = .always
                players[htButton] = AKPlayer(audioFile: htFile)
                players[htButton]?.buffering = .always
                players[clButton] = AKPlayer(audioFile: clFile)
                players[clButton]?.buffering = .always
                players[ohhButton] = AKPlayer(audioFile: ohhFile)
                players[ohhButton]?.buffering = .always
                players[chhButton] = AKPlayer(audioFile: chhFile)
                players[chhButton]?.buffering = .always
            }
            catch {
                print("Cannot initialize the sampler!")
        }
            
            do {
                // Pass array of audiokit object to the mixer
                mixer = AKMixer(Array(players.values))
                AudioKit.output = mixer
                try AudioKit.start()
            }
            catch {
                print("Cannot start AudioKit")
            }
        }
    override func viewDidDisappear(_ animated: Bool) {
            do {
                mixer = AKMixer(Array(players.values))
                AudioKit.output = mixer
                try AudioKit.start()
            }
            catch {
                print("Cannot stop AudioKit")
            }
        }
    @IBAction func buttonPressed(_ sender: UIButton) {
        players[sender]?.play()
        sender.backgroundColor = UIColor.green
    }
    @IBAction func buttonReleased(_ sender: UIButton) {
        sender.backgroundColor = UIColor.black
    }
    
}


