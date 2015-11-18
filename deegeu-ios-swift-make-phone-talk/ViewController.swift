//
//  ViewController.swift
//  deegeu-ios-swift-make-phone-talk
//
//  Created by Daniel Spiess on 11/13/15.
//  Copyright © 2015 Daniel Spiess. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {
    let speechSynthesizer = AVSpeechSynthesizer()
    var speechVoice : AVSpeechSynthesisVoice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        speechSynthesizer.delegate = self
        
        // This is a hack since the following line doesn't work. You also need to
        // make sure the voices are downloaded.
        //speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
        let voices = AVSpeechSynthesisVoice.speechVoices()
        for voice in voices {
            if "en-AU" == voice.language {
                self.speechVoice = voice
                break;
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // This is the action called when the user presses the button.
    @IBAction func speak(sender: AnyObject) {
        let speechUtterance = AVSpeechUtterance(string: "How can you tell which one of your friends has the new iPhone 6s plus?")

        // set the voice
        speechUtterance.voice = self.speechVoice
        
        // rate is 0.0 to 1.0 (default defined by AVSpeechUtteranceDefaultSpeechRate)
        speechUtterance.rate = 0.1
        
        // multiplier is between >0.0 and 2.0 (default 1.0)
        speechUtterance.pitchMultiplier = 1.25
        
        // Volume from 0.0 to 1.0 (default 1.0)
        speechUtterance.volume = 0.75
        
        // Delays before and after saying the phrase
        speechUtterance.preUtteranceDelay = 0.0
        speechUtterance.postUtteranceDelay = 0.0
        
        speechSynthesizer.speakUtterance(speechUtterance)
        
        // Give the answer, but with a different voice
        let speechUtterance2 = AVSpeechUtterance(string: "Don't worry, they'll tell you.")
        speechUtterance2.voice = self.speechVoice
        speechSynthesizer.speakUtterance(speechUtterance2)
    }
    
    // Called before speaking an utterance
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didStartSpeechUtterance utterance: AVSpeechUtterance) {
        print("About to say '\(utterance.speechString)'");
    }
    
    // Called when the synthesizer is finished speaking the utterance
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didFinishSpeechUtterance utterance: AVSpeechUtterance) {
        print("Finished saying '\(utterance.speechString)");
    }
    
    // This method is called before speaking each word in the utterance.
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let startIndex = utterance.speechString.startIndex.advancedBy(characterRange.location)
        let endIndex = startIndex.advancedBy(characterRange.length)
        print("Will speak the word '\(utterance.speechString.substringWithRange(startIndex..<endIndex))'");
    }

}

