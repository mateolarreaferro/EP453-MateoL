//
//  Synth.swift
//  MotionSynth
//
//  Created by Mateo Larrea Ferro on 3/24/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.
//

import Foundation
import AudioKit

class Synth {
        let fm:AKFMOscillatorBank!
        let filter:AKMoogLadder!
        let reverb: AKCostelloReverb!
        let flanger: AKFlanger!
        
        init() {
            fm = AKFMOscillatorBank(waveform: AKTable(.sine, phase: 0, count: 256), carrierMultiplier: 1, modulatingMultiplier: 2, modulationIndex: 20, attackDuration: 0.1, decayDuration: 0.1, sustainLevel: 1, releaseDuration: 1, pitchBend: 0, vibratoDepth: 0, vibratoRate: 0)
            flanger = AKFlanger(fm, depth: 1, feedback: 0.5, dryWetMix: 1)
            filter = AKMoogLadder(flanger, cutoffFrequency: 5000, resonance: 0.3)
            reverb = AKCostelloReverb(filter, feedback: 0.6, cutoffFrequency: 5000)
            
            AudioKit.output = reverb
            do{
                try AudioKit.start()
            }
            catch{
                print("Can't start AudioKit!!!")
            }
        }
        
        func start(noteNumber: MIDINoteNumber){
            fm.play(noteNumber: noteNumber, velocity: 127)
        }
        
        func stop(noteNumber: MIDINoteNumber){
            fm.stop(noteNumber: noteNumber)
        }
        
        func setFilter(roll: Double, pitch: Double){
            let cutoff = 10000 * scale(num: CGFloat(roll), minNum: -1.5, maxNum: 1.5, scaleMin: 0, scaleMax: 1)
            let resonance = 0.3 * scale(num: CGFloat(pitch), minNum: -1.5, maxNum: 1.5, scaleMin: 0, scaleMax: 1)
            
            filter.cutoffFrequency = Double(1000 + cutoff)
            filter.resonance = Double(0.6 + resonance)
        }
        
        func setModulationIndex(yaw: Double){
            let modulationIndex = 100 * scale(num: CGFloat(yaw), minNum: -CGFloat.pi, maxNum: CGFloat.pi, scaleMin: 0, scaleMax: 1)
            fm.modulationIndex = Double(20 + modulationIndex)
        }
        
        func scale(num: CGFloat, minNum: CGFloat, maxNum: CGFloat, scaleMin: CGFloat, scaleMax: CGFloat) -> CGFloat {
            if (num <= minNum) {return scaleMin}
            if (num >= maxNum) {return scaleMax}
            return (num-minNum)/(maxNum-minNum) * (scaleMax-scaleMin) + scaleMin
        }
    }
