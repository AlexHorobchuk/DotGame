//
//  VibrationManager.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/11/23.
//

import UIKit

class VibrationManager {
    
    static let shared = VibrationManager()
    
    private init() {}
    
    func vibrate(for style: UIImpactFeedbackGenerator.FeedbackStyle) {
        if UserDefaultsManager.shared.isVibrationEnabled {
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.prepare()
            generator.impactOccurred()
        }
    }
}
