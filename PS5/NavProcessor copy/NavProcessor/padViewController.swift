import UIKit
import AudioKit

class PadViewController: UIViewController {
    
    @IBOutlet var xyPad: XYPad!
    var filter:AKLowPassFilter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize pan gesture recognizer and add it to xyPad
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        xyPad.addGestureRecognizer(pan)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let mic = AKMicrophone()
        filter = AKLowPassFilter(mic)
        filter?.cutoffFrequency = 5000 // Hz
        filter?.resonance = 0 // dB
        AudioKit.output = filter
        do{
            try AudioKit.start()
        }
        catch{
            print("Cannot start AudioKit")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        do{
            try AudioKit.stop()
        }
        catch{
            print("Cannot stop AudioKit")
        }
    }
    // Handle pan gesture
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        // Draw circle to follow finger during pan gesture in XYPad
        let loc = recognizer.location(in: xyPad)
    
        // Ensure panning is only used to draw circle and update xloc and yloc if it does not stray outside the XYPad
        if xyPad.bounds.contains(loc) {
            xyPad.drawCircle(loc)
            let xloc = Float(loc.x/xyPad.frame.width)
            let yloc = Float((1.0 - (loc.y/xyPad.frame.height)))
            filter?.cutoffFrequency = xloc * 10000
            filter?.resonance = yloc * 60 - 20
        }
    }
}


