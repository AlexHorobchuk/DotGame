//
//  UserDefaults.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/11/23.
//

import Foundation

class UserDefaultsManager {
    
    static var shared = UserDefaultsManager()
    
    private let musicKey = "music"
    private let vibrationKey = "vibration"
    private let soundKey = "sound"
    private let money = "money"
    private let regeneration = "regeneration"
    private let stationStart = "stationStart"
    private let level = "level"
    
    private init() {
        UserDefaults.standard.register(defaults: [
            musicKey : true,
            vibrationKey : true,
            soundKey : true,
            money : 0,
            regeneration: 0,
            stationStart: 0,
            level: 0
        ])
    }
    
    var computerLevel: Int {
        get { UserDefaults.standard.integer(forKey: level) }
        set { UserDefaults.standard.set(newValue, forKey: level) }
    }
    
    var stationStartLevel: Int {
        get { UserDefaults.standard.integer(forKey: stationStart) }
        set { UserDefaults.standard.set(newValue, forKey: stationStart) }
    }
    
    var renerationLevel: Int {
        get { UserDefaults.standard.integer(forKey: regeneration) }
        set { UserDefaults.standard.set(newValue, forKey: regeneration) }
    }
    
    var moneyCount: Int {
        get { UserDefaults.standard.integer(forKey: money) }
        set { UserDefaults.standard.set(newValue, forKey: money) }
    }
    
    var isMusicEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: musicKey) }
        set {
            UserDefaults.standard.set(newValue, forKey: musicKey)
            MusicManager.shared.playBackgroundMusic()
        }
    }
    
    var isVibrationEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: vibrationKey) }
        set { UserDefaults.standard.set(newValue, forKey: vibrationKey) }
    }
    
    var isSoundEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: soundKey) }
        set { UserDefaults.standard.set(newValue, forKey: soundKey) }
    }
}
