//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Victor Hong on 2015-09-21.
//  Copyright © 2015 Victor Hong. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    //add customize pitch/speed button
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    @IBOutlet weak var speedInput: UITextField!
    @IBOutlet weak var pitchInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioSpeed(0.5)
    }

    @IBAction func playFastAudio(sender: UIButton) {
        playAudioSpeed(2.0)
    }
    
   
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playCustomSpeed(sender: UIButton) {
        
        let speed = Float(speedInput.text!)
        
        if speed == nil {
            alertAction("You did not enter anything.")
        }else if speed < 0.5 {
            alertAction("The number is below 0.5.")
        }else if speed > 2.0 {
            alertAction("The number is above 2.0.")
        }else {
            playAudioSpeed(speed!)
        }
        
    }
    
    @IBAction func playCustomPitch(sender: UIButton) {
        let pitch = Float(pitchInput.text!)
        
        if pitch == nil {
            alertAction("You did not enter anything.")
        }else if pitch < -2400 {
            alertAction("The number is below -2400.")
        }else if pitch > 2400 {
            alertAction("The number is above 2400.")
        }else {
            playAudioWithVariablePitch(pitch!)
        }

    }
    
    func playAudioSpeed(speed: Float) {
        audioPlayer.stop()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    func alertAction(titlemessage: String) {
        let alert = UIAlertController(title: titlemessage, message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
