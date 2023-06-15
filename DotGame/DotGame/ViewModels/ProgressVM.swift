//
//  ProgressVM.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/13/23.
//

import Foundation

class ProgressVM: ObservableObject {
    
    @Published var level: Int
    @Published var regenerationLevel: Int
    @Published var stationStartLevel: Int
    @Published var money: Int
    @Published var alert: AlertItem?
    
    init () {
        self.level = UserDefaultsManager.shared.computerLevel
        self.regenerationLevel = UserDefaultsManager.shared.renerationLevel
        self.stationStartLevel = UserDefaultsManager.shared.stationStartLevel
        self.money = UserDefaultsManager.shared.moneyCount
        
    }
    
    func getStationMaxRecovery() -> Int {
        let remainder = level % 10
        return (level - remainder) + 50
    }
    
    func getStationStart(owner: ParticipatorType?) -> Int {
        switch owner {
            
        case .none:
            let remainder = level % 10
            return (level - remainder) + 10
        case .some(let participator):
            
            switch participator {
                
            case .realPlayer:
                return stationStartLevel
            default:
                return level
            }
        }
    }
    
    func getRegeneration(owner: OwnerType) -> Double {
        let regeneration = 0.7 - (Double(owner == .realPlayer ? regenerationLevel : level) * 0.01)
        return regeneration > 0.3 ? regeneration : 0.3
    }
    
    func update() {
        DispatchQueue.main.async {
            self.level = UserDefaultsManager.shared.computerLevel
            self.regenerationLevel = UserDefaultsManager.shared.renerationLevel
            self.stationStartLevel = UserDefaultsManager.shared.stationStartLevel
            self.money = UserDefaultsManager.shared.moneyCount
        }
        
    }
    
    func getPriceFor(item: ItemType) -> Int {
        return 100 + (100 * (item == .regeneration ? regenerationLevel : stationStartLevel))
    }
    
    func buy(item: ItemType) {
        if canBuy(item: item) {
            UserDefaultsManager.shared.moneyCount -= getPriceFor(item: item)
            if item == .regeneration {
                UserDefaultsManager.shared.renerationLevel += 1
            }
            else {
                UserDefaultsManager.shared.stationStartLevel += 1
            }
            update()
        } else {
            alert = AlertConfirmation.notEnoughFound
        }
    }
    
    func getPrize(didWin: Bool) -> Int {
        let prize = Int.random(in: (100 + (100 * level)) / 2 ... (100 + (100 * level)))
        if didWin {
            UserDefaultsManager.shared.moneyCount += prize
            return prize
        }
        else {
            UserDefaultsManager.shared.moneyCount += prize / 4
            return prize / 4
        }
    }
    
    func canBuy(item: ItemType) -> Bool {
        guard getPriceFor(item: item) <= money else { return false }
        return true
    }
}
