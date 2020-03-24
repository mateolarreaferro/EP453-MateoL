//
//  ViewController.swift
//  MotionSynth
//
//  Created by Mateo Larrea Ferro on 3/23/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.
//

import UIKit
import CoreMotion



class ViewController: UIViewController {
    @IBOutlet weak var aX: UILabel!
    @IBOutlet weak var aY: UILabel!
    @IBOutlet weak var aZ: UILabel!
    @IBOutlet weak var gX: UILabel!
    @IBOutlet weak var gY: UILabel!
    @IBOutlet weak var gZ: UILabel!
    @IBOutlet weak var roll: UILabel!
    @IBOutlet weak var pitch: UILabel!
    @IBOutlet weak var yaw: UILabel!
    @IBOutlet weak var rm: UILabel!
    
    let motionManager: CMMotionManager = CMMotionManager()
    var timer:Timer!
    
    var square: UIView!
    var squareSize: CGFloat = 100
    
    var punto: UIView!
    var puntoSize: CGFloat = 30
    
    var synth: Synth!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Start Sensor Update
        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()
        motionManager.startDeviceMotionUpdates() //roll pitch and yaw
        //Initialize custom UIView
        square = UIView(frame: CGRect(x: self.view.center.x - squareSize/2, y: self.view.center.y - squareSize/2, width: squareSize, height: squareSize))
        square.alpha = 0.6
        square.backgroundColor = UIColor(hue: 1, saturation: 1, brightness: 1, alpha: 1)
        self.view.addSubview(square)
        
        //Initialize cutom UIViews #2
        punto = UIView(frame: CGRect(x: self.view.center.x - puntoSize/2, y: self.view.center.y - puntoSize/2, width: puntoSize, height: puntoSize))
        punto.alpha = 0.9
        square.backgroundColor = UIColor(hue: 1, saturation: 0.6, brightness: 1, alpha: 1)
        self.view.addSubview(punto)
        
        
        //initialize synth
        synth = Synth()
        synth.start(noteNumber: 60)
        
        
        //Create timer to auto call update function
        
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
     
    }

    @objc func update(){
        if let accelData = motionManager.accelerometerData {
            UpdateAccel(accelData: accelData)
        }
        if let gyroData = motionManager.gyroData {
            updateGyro(gyroData: gyroData)
        }
        if let deviceData = motionManager.deviceMotion {
            updateAttitude(attitude: deviceData.attitude) //specifies Device data instead of just attitude because there is other stuff
            trackAttitude(attitude: deviceData.attitude)
            synth.setFilter(roll: deviceData.attitude.roll, pitch: deviceData.attitude.pitch)
            synth.setModulationIndex(yaw: deviceData.attitude.yaw)
        
        }
       /* if let magneticData = motionManager.magnetometerData {
            updateAttitude(attitude: magneticData.magneticField)
            
            
        } */
    }
    func UpdateAccel(accelData: CMAccelerometerData){
        aX.text = String(format: "%.3f", accelData.acceleration.x)
        aY.text = String(format: "%.3f", accelData.acceleration.y)
        aZ.text = String(format: "%.3f", accelData.acceleration.z)
        
        
    }
    func updateGyro(gyroData:CMGyroData){
        gX.text = String(format: "%.3f", gyroData.rotationRate.x)
        gY.text = String(format: "%.3f", gyroData.rotationRate.y)
        gZ.text = String(format: "%.3f", gyroData.rotationRate.z)
    }
    func updateAttitude(attitude: CMAttitude){
        roll.text = String(format: "%.3f", attitude.roll)
        pitch.text = String(format: "%.3f", attitude.pitch)
        yaw.text = String(format: "%.3f", attitude.yaw)
        
        
    }
    
    func trackAttitude(attitude: CMAttitude){
        let maxRadius = view.frame.size.width / 2
        let roll:CGFloat = scale(num: CGFloat(attitude.roll), minNum: -1.5, maxNum: 1.5, scaleMin: -maxRadius, scaleMax: maxRadius) + self.view.center.x
        let pitch:CGFloat = scale(num: CGFloat(attitude.pitch), minNum: -1.5, maxNum: 1.5, scaleMin: -maxRadius, scaleMax: maxRadius) + self.view.center.y
        square.frame = CGRect(x: roll - squareSize/2, y: pitch - squareSize/2, width: squareSize, height: squareSize)
        square.transform = CGAffineTransform(rotationAngle: CGFloat(attitude.yaw))
    }
    /*func mangnometerData(attitude: CMALogItem){
    let maxRadius = view.frame.size.width / 2
    let roll:CGFloat = scale(num: CGFloat(attitude.), minNum: -1.5, maxNum: 1.5, scaleMin: -maxRadius, scaleMax: maxRadius) + self.view.center.x
    let pitch:CGFloat = scale(num: CGFloat(attitude.pitch), minNum: -1.5, maxNum: 1.5, scaleMin: -maxRadius, scaleMax: maxRadius) + self.view.center.y
    square.frame = CGRect(x: roll - squareSize/2, y: pitch - squareSize/2, width: squareSize, height: squareSize)
        square.transform = CGAffineTransform(rotationAngle: CGFloat(attitude.yaw))
 */
        
    }
    
    func scale(num: CGFloat, minNum: CGFloat, maxNum: CGFloat, scaleMin: CGFloat, scaleMax: CGFloat) -> CGFloat {
        if (num <= minNum) { return scaleMin }
        if(num >= maxNum) { return scaleMax }
        return (num-minNum)/(maxNum-minNum) * (scaleMax-scaleMin) + scaleMin

    }


