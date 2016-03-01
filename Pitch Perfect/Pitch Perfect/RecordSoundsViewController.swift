//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Allen Czerwinski on 2/26/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var recordingButton: UIButton!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioURL: NSURL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setUpAudioRecorder()
        
//        recordingSession = AVAudioSession.sharedInstance()
//        
//        do {
//            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
//            try recordingSession.setActive(true)
//            recordingSession.requestRecordPermission() { [unowned self] (allowed: Bool) -> Void in dispatch_async(dispatch_get_main_queue()) {
//                    if allowed {
//                    self.loadRecordingUI()
//                    } else {
//                        print("failed to record") // print(err.debugDescription)
//                    }
//                }
//                }
//            } catch /*let err as NSError*/ {
//               print("failed to record") // print(err.debug
//            }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
//    
//    func setUpAudioRecorder() {
//        do {
//            let basePath: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!
//            let pathComponents = [basePath, "theAudio.m4a"]
//            self.audioURL = NSURL.fileURLWithPathComponents(pathComponents)
//            
//            let session = AVAudioSession.sharedInstance()
//            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
//            try session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
//            try session.setActive(true)
//            
//            var recordSettings = [String: AnyObject]()
//            recordSettings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
//            recordSettings[AVSampleRateKey] = 44100.0
//            recordSettings[AVNumberOfChannelsKey] = 2
//            
//            self.audioRecorder = try AVAudioRecorder(URL: self.audioURL!, settings: recordSettings)
//            self.audioRecorder!.meteringEnabled = true
//            self.audioRecorder!.prepareToRecord()
//            
//        } catch {
//            
//        }
//    }
    
//    func loadRecordingUI() {
//        recordButton = UIButton(frame: CGRect(x: 64, y: 64, width: 128, height: 64))
//        recordButton.setTitle("Tap to record", forState: .Normal)
//        recordButton.titleLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)
//        recordButton.addTarget(self, action: "recordTapped", forControlEvents: .TouchUpInside)
//        view.addSubview(recordButton)
//    }
//
//    class func getDocumentsDirectory() -> String {
//        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
//        let documentsDirectory = paths[0]
//        return documentsDirectory
//    }
//    
//    func startRecording() {
//        let audioFilename = getDocumentsDirectory().stringByAppendingPathComponent("recording.m4a")
//        let audioURL = NSURL(fileURLWithPath: audioFilename)
//        
//        let settings = [
//            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//            AVSampleRateKey: 12000.0,
//            AVNumberOfChannelsKey: 1 as NSNumber,
//            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
//        ]
//        
//        do {
//            audioRecorder = try AVAudioRecorder(URL: audioURL, settings: settings)
//            audioRecorder.delegate = self
//            audioRecorder.record()
//            
//            recordButton.setTitle("Tap to Stop", forState: .Normal)
//        } catch {
//            finishRecording(success: false)
//        }
//    }
//    
//    func finishRecording(success success: Bool) {
//        audioRecorder.stop()
//        audioRecorder = nil
//        
//        if success {
//            recordButton.setTitle("Tap to Re-record", forState: .Normal)
//        } else {
//            recordButton.setTitle("Tap to Record", forState: .Normal)
//            print("Recording failed")
//        }
//    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        
//        if self.audioRecorder!.recording {
//            self.audioRecorder.stop()
//            sender.setTitle("RECORD", forState: UIControlState.Normal)
//        } else {
//            do {
//                try AVAudioSession.sharedInstance().setActive(true)
//                self.audioRecorder!.record()
//                sender.setTitle("STOP", forState:  UIControlState.Normal)
//            } catch {
//                
//            }
//        }
        recordButton.enabled = false
        recordingInProgress.hidden = false
        stopButton.hidden = false
        print("in recordAudio")
//        if audioRecorder == nil {
//            startRecording()
//        } else {
//            finishRecording(success: true)
//        }
        
    }
    
//    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
//        if !flag {
//            finishRecording(success: false)
//        }
//    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        
        recordingInProgress.hidden = true
    }
    

}

