//
//  ViewController.swift
//  Timer
//
//  Created by Mateo Larrea Ferro on 4/7/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    var time = 0
    
    //timer
    var timer = Timer()
    
    @IBAction func startButton(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.action), userInfo: nil, repeats: true)
    }
    @IBAction func pauseButton(_ sender: Any) {
        timer.invalidate()
    }
    @IBAction func resetButton(_ sender: Any) {
        timer.invalidate()
        time = 0
        label.text = String("00:00")
    }
    @objc func action(){
        time += 1
        label.text = String(time)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

