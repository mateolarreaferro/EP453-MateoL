//
//  Synth.swift
//  Visualizer
//
//  Created by Mateo Larrea Ferro on 4/7/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.
//

import AudioKit

class Synth {
    //AKNodes
    //synth stuff
    var noise: AKWhiteNoise!
    // other options: AKBrownianNoise AKPinkNoise
  
    var filter1: AKResonantFilter!
    var filter2: AKResonantFilter!
    var filter3: AKResonantFilter!
    var filter4: AKResonantFilter!
    var filter5: AKResonantFilter!
    var filter6: AKResonantFilter!
    var filter7: AKResonantFilter!
    var filter8: AKResonantFilter!
    var filter9: AKResonantFilter!
    var filter10: AKResonantFilter!
    var mixer: AKMixer!
    
    
    
    var reverb: AKReverb!
    
    //AK Nodes AnALYSIS
    var fft:AKFFTTap! //gives freq info
    var mic:AKMicrophone!
    var amp:AKAmplitudeTap! //amplitude analysis
    
    init () {
        //Initialize Synth related stuff
        noise = AKWhiteNoise (amplitude: 0)
        filter1 = AKResonantFilter.init(noise, frequency: 40, bandwidth: 600)
        filter2 = AKResonantFilter.init(noise, frequency: 1945, bandwidth: 600)
        filter3 = AKResonantFilter.init(noise, frequency: 4000, bandwidth: 600)
        filter4 = AKResonantFilter.init(noise, frequency: 6000, bandwidth: 600)
        filter5 = AKResonantFilter.init(noise, frequency: 8000, bandwidth: 600)
        filter6 = AKResonantFilter.init(noise, frequency: 10000, bandwidth: 600)
        filter7 = AKResonantFilter.init(noise, frequency: 12000, bandwidth: 600)
        filter8 = AKResonantFilter.init(noise, frequency: 14000, bandwidth: 600)
        filter9 = AKResonantFilter.init(noise, frequency: 16000, bandwidth: 600)
        filter10 = AKResonantFilter.init(noise, frequency: 19050, bandwidth: 600)
        
        mixer = AKMixer(filter1,filter2,filter3,filter4, filter5, filter6,filter7,filter8,filter9,filter10)
        
        //(noise, cutoffFrequency: AudioKit.deviceSampleRate / 2, resonance: 0) // -2 ~ 40
        //no cutoff to start with
        reverb = AKReverb(mixer)
        
        mic = AKMicrophone()
        amp = AKAmplitudeTap(mic)
        mic.start()
        amp.start()
        
        fft = AKFFTTap(mixer) //can also pass reverb
        
        AKSettings.bufferLength = .shortest
        
        AudioKit.output = reverb
        do {
            try AudioKit.start()
        }
        catch {
            print("Cannot start audiokit")
        }
        Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(updateAmp), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateAmp(){
        // amp range 0~1 for noise
        // Number 20 is to amplify the microphone anlysis result
        noise.amplitude = Double(amp.amplitude) * 20
    }
    //256 or 512 descrete frequenct bins
    func getFFT () -> [Double] { //array format because its holding a frequency bin
        return fft.fftData
    }
    //the range of freq should be between 0 ~ 1
    func setFrequency(freq: Float) {
        filter1.frequency = freq * AudioKit.deviceSampleRate / 2
        filter2.frequency = freq * AudioKit.deviceSampleRate / 2
        filter3.frequency = freq * AudioKit.deviceSampleRate / 2
        filter4.frequency = freq * AudioKit.deviceSampleRate / 2
        filter5.frequency = freq * AudioKit.deviceSampleRate / 2
        filter6.frequency = freq * AudioKit.deviceSampleRate / 2
        filter7.frequency = freq * AudioKit.deviceSampleRate / 2
        filter8.frequency = freq * AudioKit.deviceSampleRate / 2
        filter9.frequency = freq * AudioKit.deviceSampleRate / 2
        filter10.frequency = freq * AudioKit.deviceSampleRate / 2
        
    }
    //From -20 ~ 20
    func setResonance(res: Float){
        filter1.bandwidth = res * 40 - 20
        filter2.bandwidth = res * 40 - 20
        filter3.bandwidth = res * 40 - 20
        filter4.bandwidth = res * 40 - 20
        filter5.bandwidth = res * 40 - 20
        filter6.bandwidth = res * 40 - 20
        filter7.bandwidth = res * 40 - 20
        filter8.bandwidth = res * 40 - 20
        filter9.bandwidth = res * 40 - 20
        filter10.bandwidth = res * 40 - 20
        
        
    }
}
