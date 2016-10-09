//
//  PlaySoundsViewController.swift
//  iOS9Window_with_storyboard
//
//  Created by Volodymyr Poplavskiy on 10/6/16.
//  Copyright © 2016 Volodymyr Poplavskiy. All rights reserved.
//

import UIKit
import AVFoundation
class PlaySoundsViewController: UIViewController {
    var recordedAudioURL:NSURL?
    
    @IBOutlet weak var stopPlayBackButton: UIButton!
    @IBOutlet weak var revertButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    
    
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    enum buttonType: Int {
        case Slow = 0, Fast, Chipmunk, Weider, Echo, Reverb
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
setupAudio()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated:Bool){configureUI(.NotPlaying)}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var recordedAudio: NSURL!
        @IBAction func playSoundForButton(sender: UIButton) {
        print("Play Sound Button Pressed")
        switch (buttonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Weider:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        configureUI(.Playing)
    }
    
    @IBAction func stopButtonPressed(sender: AnyObject) {
        print("Stop Audio Button Pressed")
        stopAudio()
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
