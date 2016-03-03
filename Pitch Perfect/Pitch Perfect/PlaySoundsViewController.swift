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

    // CITATION: Images from websites www.popsci.com, 
    // www.creativeapplications.net, and www.iconarchive.com
    
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
        
        audioPlayer.enableRate = true
        
        audioPlayer.prepareToPlay()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        fixImages()
        
    }
    
    // Make images round
    
    func fixImages() {
        reverbImage.layer.cornerRadius = reverbImage.frame.size.width / 2
        reverbImage.clipsToBounds = true
        
        distortionImage.layer.cornerRadius = distortionImage.frame.size.width / 2
        distortionImage.clipsToBounds = true
        
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
    
    // CITATION: borrowed heavily from Udacity forum page:
    // "https://discussions.udacity.com/t/adding-exceeds-
    // specifications-echo-effect/12929" as well as Stack Overflow
    // post: "http://stackoverflow.com/questions/25333140/using-
    // sound-effects-with-audioengine"
    
    // Set reverb, distortion, and echo effects in separate buttons
    
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
        
        audioEngine.connect(audioPlayerNode, to: effect as! AVAudioNode, format: nil)
        audioEngine.connect(effect as! AVAudioNode, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        try! audioEngine.start()
    
        audioPlayerNode.play()
        
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
