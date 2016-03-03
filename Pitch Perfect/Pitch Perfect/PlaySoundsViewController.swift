//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Allen Czerwinski on 2/28/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var reverbImage: UIButton!
    @IBOutlet weak var distortionImage: UIButton!
    @IBOutlet weak var echoImage: UIButton!
    
    
    var audioPlayer: AVAudioPlayer!
    var audioURL: NSURL?
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare audioFile to be played, and audioEngine to support variable pitch
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
//        
        
//        audioBuffer = try! AVAudioPCMBuffer(PCMFormat: audioFile.processingFormat, frameCapacity: AVAudioFrameCount(audioFile.length))
//        try! audioFile.readIntoBuffer(audioBuffer)
        
        audioPlayer.enableRate = true
        
        audioPlayer.prepareToPlay()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        fixImages()
        
    }
    
    func fixImages() {
        reverbImage.layer.cornerRadius = reverbImage.frame.size.width / 2
        reverbImage.clipsToBounds = true
        
        distortionImage.layer.cornerRadius = distortionImage.frame.size.width / 2
        distortionImage.clipsToBounds = true
        
//        echoImage.layer.cornerRadius = echoImage.frame.size.width / 2
//        echoImage.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func playButton(sender: UIButton) {
        
        stopAndResetAudio()
        
        if sender.tag == 0 {
            audioPlayer.rate = 0.5
        } else {
            audioPlayer.rate = 2.0
        }
        
        audioPlayer.play()
        
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        let highPitchEffect = AVAudioUnitTimePitch()
        highPitchEffect.pitch = 1000
        playAudioWithVariableEffects(highPitchEffect)
        
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        
        let lowPitchEffect = AVAudioUnitTimePitch()
        lowPitchEffect.pitch = -1000
        playAudioWithVariableEffects(lowPitchEffect)
        
    }
    
    @IBAction func reverbButtonPressed(sender: UIButton) {
        
        let reverbEffect = AVAudioUnitReverb()
        reverbEffect.loadFactoryPreset(.Cathedral)
        reverbEffect.wetDryMix = 70
        playAudioWithVariableEffects(reverbEffect)
        
    }
    
    @IBAction func distortionButtonPressed(sender: UIButton) {
        
        let distortionEffect = AVAudioUnitDistortion()
        distortionEffect.loadFactoryPreset(.MultiBrokenSpeaker)
        distortionEffect.wetDryMix = 30
        playAudioWithVariableEffects(distortionEffect)
        
    }
    
    @IBAction func echoButtonPressed(sender: UIButton) {
        
        let delayEffect = AVAudioUnitDelay()
        delayEffect.delayTime = 0.7
        playAudioWithVariableEffects(delayEffect)
    }
    
    
    
    
    func playAudioWithVariableEffects(effect: NSObject) {
        
        stopAndResetAudio()
        
        // Connect audioPlayerNode to the Pitch effect, and specify the audio output
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(effect as! AVAudioNode)
        
//        let audioPlayerNodeReverb = AVAudioPlayerNode()
//        audioEngine.attachNode(audioPlayerNodeReverb)
        
//        let audioPlayerNodeDistortion = AVAudioPlayerNode()
//        audioEngine.attachNode(audioPlayerNodeDistortion)
        
//        let changePitchEffect = AVAudioUnitTimePitch()
//        changePitchEffect.pitch = pitch
        
//        let changeReverbEffect = AVAudioUnitReverb()
        
        // NEED TO ADD BACK THE REVERB ARGUMENT
//        changeReverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.Cathedral)
//        changeReverbEffect.wetDryMix = 50
        
//        let changeDistortionEffect = AVAudioUnitDistortion()
//        changeDistortionEffect.loadFactoryPreset(AVAudioUnitDistortionPreset(rawValue: distortion)!)
//        changeDistortionEffect.wetDryMix = 25

        
//        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: effect as! AVAudioNode, format: nil)
        audioEngine.connect(effect as! AVAudioNode, to: audioEngine.outputNode, format: nil)
        
        // Connect distortion effect
        
//        audioEngine.attachNode(changeDistortionEffect)
//        audioEngine.connect(audioPlayerNodeDistortion, to: changeDistortionEffect, format: audioBuffer.format)
//        audioEngine.connect(changeDistortionEffect, to: audioEngine.mainMixerNode, format: audioBuffer.format)
        
        // Connect reverb effect
        
//        audioEngine.attachNode(changeReverbEffect)
//        audioEngine.connect(audioPlayerNode, to: changeReverbEffect, format: audioBuffer.format)
//        audioEngine.connect(changeReverbEffect, to: audioEngine.mainMixerNode, format: audioBuffer.format)
        
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
//        audioPlayerNodeDistortion.scheduleBuffer(audioBuffer, atTime: nil, options: AVAudioPlayerNodeBufferOptions.Loops, completionHandler: nil)
//        audioPlayerNodeDistortion.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
//        audioPlayerNodeReverb.scheduleBuffer(audioBuffer, atTime: nil, options: AVAudioPlayerNodeBufferOptions.Loops, completionHandler: nil)
//        audioPlayerNodeReverb.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
    
        audioPlayerNode.play()
//        audioPlayerNodeDistortion.play()
//        audioPlayerNodeReverb.play()
        
    }
    
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        
        stopAndResetAudio()
        
    }
    
    func stopAndResetAudio() {
        
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        
    }

}
