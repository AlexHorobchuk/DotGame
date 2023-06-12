//
//  SoundManager.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/11/23.
//

import UIKit
import AVFoundation

class SoundManager {
    
    static let shared = SoundManager()
    
    private init() {}
    
    var player: AVAudioPlayer?
    
    enum Sounds: String {
        case won = "Win",
        loose = "Defeat",
        click = "Click",
        hitStation = "Pop"
    }
      
    func playSound(for name: Sounds) {
        let isSoundOn = UserDefaultsManager.shared.isSoundEnabled
        if isSoundOn {
            if let url = Bundle.main.url(forResource: name.rawValue, withExtension: "mp3") {
                do {
                    player = try AVAudioPlayer(contentsOf: url)
                    player?.numberOfLoops = 0
                    player?.play()
                } catch {
                    print("mussic error")
                }
            }
        } else {
            player?.stop()
            player = nil
        }
    }
}
