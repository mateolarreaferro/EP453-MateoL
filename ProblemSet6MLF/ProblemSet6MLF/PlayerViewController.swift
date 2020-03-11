//
//  PlayerViewController.swift
//  ProblemSet6MLF
//
//  Created by Mateo Larrea Ferro on 3/10/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.
//

import UIKit
import AudioKit

class PlayerViewController: UIViewController {
    @IBOutlet weak var l1Button: UIButton!
    @IBOutlet weak var l2Button: UIButton!
    @IBOutlet weak var vol1: UISlider!
    @IBOutlet weak var vol2: UISlider!
    @IBOutlet weak var stopButton: UIButton!
    
    var myMixer:AKMixer?
    var players = [UIButton:AKPlayer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func viewDidAppear(_ animated: Bool) {
               do {
                   let l1File = try AKAudioFile(readFileName: "loop1.wav", baseDir: .resources)
                let l2File = try AKAudioFile(readFileName: "loop2.wav", baseDir: .resources)
                
                players[l1Button] = AKPlayer(audioFile: l1File)
                players[l1Button]?.buffering = .always
                players[l2Button] = AKPlayer(audioFile: l1File)
                players[l2Button]?.buffering = .always
                players[stopButton] = AKPlayer(audioFile: l1File, l2File)
                players[stopButton]?.buffering = .always
                players[stop(_:)]
                

        }
        catch {
                    print("Cannot initialize the sampler!")
            }
                
                do {
                    // Pass array of audiokit object to the mixer
                    myMixer = AKMixer(Array(players.values))
                    AudioKit.output = myMixer
                    try AudioKit.start()
                }
                catch {
                    print("Cannot start AudioKit")
                }
            }
        override func viewDidDisappear(_ animated: Bool) {
                do {
                    myMixer = AKMixer(Array(players.values))
                    AudioKit.output = myMixer
                    try AudioKit.start()
                }
                catch {
                    print("Cannot stop AudioKit")
                }
            }
        @IBAction func buttonPressed(_ sender: UIButton) {
            players[sender]?.isLooping
            sender.backgroundColor = UIColor.green
        }
        @IBAction func buttonReleased(_ sender: UIButton) {
            players[sender]?.stop()
            sender.backgroundColor = UIColor.black
    


}

    @IBAction func stop(_ sender: Any) {
    }

}
