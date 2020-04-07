//
//  AudioRecorder.swift
//  AudioRecorder
//
//  Created by Mateo Larrea Ferro on 4/6/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.

import AudioKit

//enum is enumeration
enum SourceType: String, CaseIterable { //uses string instead of int
    case microphone = "Microphone"
    case synthesizer = "Synthesizer"
}
class AudioRecorder {
    var mic: AKMicrophone!
    var osc: AKOscillatorBank!
    var reverb: AKReverb!
    var mixer: AKMixer!
    var curSource: SourceType = .microphone
    
    var timer: Timer!
    var curNote: MIDINoteNumber = 60
    var noteLenght: Double = 02
    
    var file: AKAudioFile!
    var recorder: AKNodeRecorder!
    
    init () {
        mic = AKMicrophone()
        osc = AKOscillatorBank (waveform: AKTable(.sine))
       reverb = AKReverb (mic)
        AudioKit.output = mixer
        mixer = AKMixer([reverb, osc])
        start()
        //startTimer () Just for testing purpose
        
    }
    func startRecording (source: SourceType) { //based on Picker View --> source is the user's input
        do {
            try file = AKAudioFile()
            curSource = source
            switch source {
            case .microphone:
                recorder = try AKNodeRecorder(node: mic, file: file)
                mic.volume = 1.0
                mic.start()
                break
            case .synthesizer:
                recorder = try AKNodeRecorder(node: osc , file: file)
                mic.volume = 0.0
                startTimer()
                break
            }
            try recorder.record()
        }
        catch {
            print("Error in start recording")
        }
    }
    func stopRecording (){
        recorder.stop()
        switch curSource {
        case .microphone:
            mic.stop()
            break
        case.synthesizer:
            stopTimer()
            break
        }
        saveRecording()
    }
    func saveRecording () {
        let format = DateFormatter()
        format.dateFormat = "yMMddHHmmss" //specifies the format the DateFormatter func will use
        recorder.audioFile?
            .exportAsynchronously(name: format.string(from: Date()), baseDir: .documents, exportFormat: .wav, callback: {(_,_) -> Void in
                //Closure. Kind of a callback func (what to do once file is saved
                print ("Recording has been saved!")
            } )
    }
    func startTimer () {
               timer = Timer.scheduledTimer(timeInterval: noteLenght, target: self, selector: #selector(playNote), userInfo: nil, repeats: true)
           }
    @objc func playNote(){
    //Timer.scheduledTimer is legacy code from objective C
        osc.stop(noteNumber: curNote)
        curNote = MIDINoteNumber.random(in: 60...72)
        osc.play(noteNumber: curNote, velocity: 127)
    }
    func stopTimer(){
        timer.invalidate() //this is how you stop timer
        osc.stop(noteNumber: curNote)
    }
    func start () {
        do {
            try AudioKit.start()
        }
        catch {
            print("Cannot Start AudioKit")
        }
    }
    func stop () {
        do {
            try AudioKit.stop()
        }
        catch {
            print("Cannot stop AudioKit")
        }
    }
    
    /*@IBAction func reverbSlider(_ sender: UISlider) {}
        switch sender {
       case revSlider: reverb?.dryWetMix = Double(sender.value)
        default: break
    } */
    
}
