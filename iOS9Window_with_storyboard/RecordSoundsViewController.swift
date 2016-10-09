//
//  ViewController.swift
//  iOS9Window_with_storyboard
//
//  Created by Volodymyr Poplavskiy on 4/19/16.
//  Copyright © 2016 Volodymyr Poplavskiy. All rights reserved.
//

import UIKit
import AVFoundation
class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    var audioRecorder: AVAudioRecorder!
    var recordings = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: AnyObject) {
        recordLabel.text = "Recording in progress..."
        stopButton.enabled = true
        recordButton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        print(dirPath)
        let recordingName = "recordedVoice\(NSDate()).wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        //print("\(filePath)")
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        recordings += 1
        print(recordingName)
    }
        @IBAction func stopRecord(sender: AnyObject) {
        stopButton.enabled = false
        recordButton.enabled = true
        recordLabel.text = "Tap to record"
        audioRecorder.stop()
        let audioSesion = AVAudioSession.sharedInstance()
        try! audioSesion.setActive(false)
    }
    override func viewWillAppear(animated: Bool) {
        stopButton.enabled = false
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
            let playSoundVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        //print("YES")
        if(flag){
        self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        } else {print("Failed")}
        }
}

