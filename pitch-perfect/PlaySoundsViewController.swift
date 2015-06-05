//  Audio Effects
//
//  PlaySoundsViewController.swift
//  pitch-perfect
//
//  Created by Raul Cajias on 16/05/15.
//  Copyright (c) 2015 PilotRex. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var avAudioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine : AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avAudioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        avAudioPlayer.enableRate = true
        
        UIDevice.currentDevice().batteryMonitoringEnabled = true
        UIDevice.currentDevice().batteryLevel
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    ///
    /// Plays the recorded audio at half the speed
    @IBAction func slowButtonAction(sender: UIButton) {
        playAtRate(0.5)
    }

    ///
    /// Plays the recorded audio at a higher pitch
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    ///
    /// Plays the recorded audio at a lower pitch
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }

    ///
    /// Plays audio given a pitch value between -2400 to 2400
    private func playAudioWithVariablePitch(pitch:Float){
        stopAll()
        var avAudioNode = AVAudioPlayerNode()
        audioEngine.attachNode(avAudioNode)
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        audioEngine.connect(avAudioNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        avAudioNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        avAudioNode.play()
    }
    

    ///
    /// Plays the recorded audio at 50% faster speed
    @IBAction func fastButtonAction(sender: UIButton) {
        playAtRate(1.5)
    }

    private func stopAll(){
        audioEngine.stop()
        audioEngine.reset()
        avAudioPlayer.stop()
        avAudioPlayer.currentTime = 0
    }
    
    private func playAtRate(rate :Float){
        stopAll()
        avAudioPlayer.rate = rate
        avAudioPlayer.play()
    }
    
    @IBAction func stopButtonAction(sender: UIButton) {
        stopAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
