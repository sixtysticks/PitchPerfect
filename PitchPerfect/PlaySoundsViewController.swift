//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by David Gibbs on 28/07/2016.
//  Copyright © 2016 SixtySticks. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    enum ButtonType: Int {
        case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb
    }
    
    
    @IBAction func playSoundForButton(sender: UIButton) {
        switch (ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.4)
        case .Fast:
            playSound(rate: 2.2)
        case .Chipmunk:
            playSound(pitch: 1200)
        case .Vader:
            playSound(pitch: -1200)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        
        configureUI(PlayingState.Playing)

    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.pitchPerfectPrimaryColor()
        setupAudio()
    }
    
    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
