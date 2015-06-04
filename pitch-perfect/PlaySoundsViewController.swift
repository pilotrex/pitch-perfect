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

    @IBAction func slowButtonAction(sender: UIButton) {
        playAtRate(0.5)
    }

    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }

    private func playAudioWithVariablePitch(pitch:Float){
        avAudioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
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
    

    @IBAction func fastButtonAction(sender: UIButton) {
        playAtRate(1.5)
    }
    
    private func playAtRate(rate :Float){
        avAudioPlayer.stop()
        avAudioPlayer.currentTime = 0
        avAudioPlayer.rate = rate
        avAudioPlayer.play()
    }
    
    @IBAction func stopButtonAction(sender: UIButton) {
        avAudioPlayer.stop()
        avAudioPlayer.currentTime = 0
        audioEngine.stop()
        audioEngine.reset()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
