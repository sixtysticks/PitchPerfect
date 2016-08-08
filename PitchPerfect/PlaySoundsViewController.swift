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
    
    // MARK: Outlets
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: Stack View Outlets
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var snailAndRabbitStackView: UIStackView!
    @IBOutlet weak var chipmunkAndDarthStackView: UIStackView!
    @IBOutlet weak var echoAndReverbStackView: UIStackView!
    @IBOutlet weak var stopButtonStackView: UIStackView!
    
    // MARK: Instance Variables and Enums
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    enum ButtonType: Int {
        case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb
    }
    
    //MARK: Custom Methods
    
    func changeLayoutBasedOnOrientation() -> Void {
        let orientation = UIApplication.sharedApplication().statusBarOrientation
        
        if orientation.isPortrait {
            self.stackView.axis = .Vertical
            self.snailAndRabbitStackView.axis = .Horizontal
            self.chipmunkAndDarthStackView.axis = .Horizontal
            self.echoAndReverbStackView.axis = .Horizontal
            self.stopButtonStackView.axis = .Horizontal
        } else {
            self.stackView.axis = .Horizontal
            self.snailAndRabbitStackView.axis = .Vertical
            self.chipmunkAndDarthStackView.axis = .Vertical
            self.echoAndReverbStackView.axis = .Vertical
            self.stopButtonStackView.axis = .Vertical
        }
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
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ppPrimaryColor
        changeLayoutBasedOnOrientation()
        setupAudio()
    }
    
    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ (context) -> Void in
            self.changeLayoutBasedOnOrientation()
            }, completion: nil)
    }
    
}