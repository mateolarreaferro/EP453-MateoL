import Foundation
import AudioKit

class Synth2 {
        let fm:AKFMOscillatorBank!
        let filter:AKMoogLadder!
        let reverb: AKCostelloReverb!
        let flanger: AKFlanger!
        var ids = [Int:Int]()
        var nodes = [[AKNode]]()
        var count = 0
        
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

    }

