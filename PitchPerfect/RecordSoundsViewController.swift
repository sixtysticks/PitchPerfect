//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by David Gibbs on 27/07/2016.
//  Copyright © 2016 SixtySticks. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    // MARK: Outlets

    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    // MARK: Instance Variables
    
    var audioRecorder: AVAudioRecorder!
    
    // MARK: Computed Properties
    
    var isRecording: Bool! {
        // The following is known as a 'property observer'
        didSet {
            stopRecordingButton.enabled = isRecording
            recordingButton.enabled = !isRecording
            recordingLabel.text = isRecording! ? "Recording in Progress" : "Tap to Record"
            recordingLabel.textColor = isRecording! ? ppSecondaryColor : UIColor.whiteColor()
        }
    }
    
    //MARK: Custom Methods
    
    @IBAction func recordAudio(sender: UIButton) {
        isRecording = true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: .DefaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopRecording(sender: UIButton) {
        isRecording = false
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AVAudioRecorder finished saving recording")
        if (flag) {
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        } else {
            print("recording failed")
        }
    }
    
    // MARK: Overrides
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = ppPrimaryColor
        
        let navBar = self.navigationController?.navigationBar
        navBar!.translucent = false
        navBar!.setBackgroundImage(UIImage(), forBarPosition: .Any, barMetrics: .Default)
        navBar!.shadowImage = UIImage()
        navBar!.barTintColor = UIColor.whiteColor()
        navBar!.tintColor = ppPrimaryColor
        navBar!.titleTextAttributes = [NSForegroundColorAttributeName: ppPrimaryColor]
    }
    
    override func viewWillAppear(animated: Bool) {
        stopRecordingButton.enabled = false
    }
}
