//
//  Synth.swift
//  MultiTouchSynth
//
//  Created by Mateo Larrea Ferro on 3/30/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.
//
import AudioKit

class Synth {
    
    let mixer:AKMixer = AKMixer()
    var ids = [Int:Int]()
    var nodes = [[AKNode]]()
    var count = 0
    
    init() {
        AudioKit.output = mixer
        do{
            try AudioKit.start()
        }
        catch {
            print("Cannot start ")
        }
        for _ in 0..<10 {
            addSynth()
        }
    }
 
    func addSynth(){
        let osc = AKMorphingOscillator(waveformArray: [AKTable(.sine), AKTable(.triangle), AKTable(.sawtooth), AKTable(.square)])
        osc.rampDuration = 0
        let filter = AKStringResonator(osc)
        filter.rampDuration = 0
        let env = AKAmplitudeEnvelope(filter)
        env.attackDuration = 0.1
        env.decayDuration = 0.1
        env.releaseDuration = 0.1
        let reverb = AKZitaReverb(env)
        mixer.connect(input: reverb)
        //Keep track of all our AKNodes so that we can modify them later
        nodes.append([osc, filter, env, reverb])
        osc.start()
    }
    
    func update(id: Int, point: CGPoint){
        //Check if the hash id from a touch point exsits in the ids dictionary
        if ids[id] == nil {
            //if the id does not exist, make a link between the hash id and count id in this synth class
            ids[id] = count
            //Advance the count
            count += 1
            //Start the synthesizer for this particular touch
            let synths = nodes[ids[id]!]
            let env = synths[2] as! AKAmplitudeEnvelope
            env.start()
        }
        //Convert point.y (0~1) to frequency range (60 ~ 3000)
        let freq = scale(num: point.y, minNum: 0, maxNum: 1, scaleMin: 60, scaleMax: 3000)
        let synths = nodes[ids[id]!]
        let osc = synths[0] as! AKMorphingOscillator
        osc.frequency = Double(freq)
        //Morph between four wavetables (0 ~ 3)
        osc.index = Double(point.x) * 3
        let filter = synths[1] as! AKStringResonator
        filter.fundamentalFrequency = Double(freq)
    }
    
    func stop(id: Int){
        let synths = nodes[ids[id]!]
        (synths[2] as! AKAmplitudeEnvelope).stop()
        ids.removeValue(forKey: id)
        count -= 1
        //count cannot be less that 0
    }
    
    func scale(num: CGFloat, minNum: CGFloat, maxNum: CGFloat,
    scaleMin: CGFloat, scaleMax: CGFloat) -> CGFloat {
        if (num <= minNum) {return scaleMin}
        if (num >= maxNum) {return scaleMax}
        return (num-minNum)/(maxNum-minNum) * (scaleMax-scaleMin) + scaleMin
    }
}
