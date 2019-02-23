//
//  ViewController.swift
//  Claudiountdown
//
//  Created by Ricardo Silva on 20/02/2019.
//  Copyright © 2019 Ricardo Silva. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var player: AVAudioPlayer?
    
    var releaseDate: Date? = nil
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let releaseDateString = "2019-03-29 18:30:00"
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        releaseDate = releaseDateFormatter.date(from: releaseDateString)!
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector:#selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        
        guard let url = Bundle.main.url(forResource: "finalCountdown", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player?.numberOfLoops = -1
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func updateTimer() {
        let currentDate = Date()
        let diffDateComponents = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate!)
        
        timerLabel.text = "\(String(format: "%02d", diffDateComponents.day!)) dias, \(String(format: "%02d", diffDateComponents.hour!)):\(String(format: "%02d", diffDateComponents.minute!)):\(String(format: "%02d", diffDateComponents.second!))"
    }

}

