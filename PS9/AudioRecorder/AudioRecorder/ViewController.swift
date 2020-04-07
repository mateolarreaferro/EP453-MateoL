//
//  ViewController.swift
//  AudioRecorder
//
//  Created by Mateo Larrea Ferro on 4/6/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.
//

import UIKit
import AudioKitUI

class ViewController: UIViewController {
    
    @IBOutlet weak var sourcePickerView: UIPickerView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var plotView: UIView!
    
    @IBOutlet weak var revSlider: UISlider!
    
    
    let audioSource = SourceType.allCases
    let audioRecorder = AudioRecorder()
    //keep adding for more options -->
    // let audioSource = ["Microphone", "Synthesizer"] previous form

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourcePickerView.delegate = self //view controller will be incharge
        sourcePickerView.dataSource = self //view controller is responsible for providing data (microphone, synth) for the picker view
        // Do any additional setup after loading the view.
        
        let rollingPlot = AKRollingOutputPlot.createView(width: plotView.frame.size.width, height: plotView.frame.size.height)
        plotView.addSubview(rollingPlot)
    }
    @IBAction func record(_ sender: UIButton) {
        if recordButton.isSelected {
            recordButton.isSelected = false
            audioRecorder.stopRecording()
        }
        else {
            let selectedIndex = sourcePickerView.selectedRow(inComponent: 0)
            recordButton.isSelected = true
            audioRecorder.startRecording(source: audioSource[selectedIndex])
        }
    }
}
//Mark: - UIPicker View relate code
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //the number of colums that the picker view should display
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return audioSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return audioSource[row].rawValue //ensures consistency of data mgmt
    }
    
}

