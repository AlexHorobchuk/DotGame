//
//  Bot.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/30/23.
//

import Foundation

final class BotPlayer: Participator {
    
    override init(stations: [Station], type: ParticipatorType) {
        super.init(stations: stations, type: type)
    }
    
    private func makeDecision() -> Bool {
        return [true, false, false, false].randomElement()!
    }
    
    func findStationToAttack(stations: [Station]) -> Station? {
        guard let station = stations.filter({ $0.owner != self.type }) .sorted(by: {$0.ballsAmount < $1.ballsAmount}).first
        else { return nil }
        return station
        
    }
    
    func clearStation() {
        selectedStations = []
    }
    
    func getAllBalls() -> Int {
        var balls = 0
        for station in selectedStations {
            balls += station.ballsAmount
        }
        return balls
    }
    
    func getSortedStation() -> [Station] {
        return selectedStations.sorted(by: { $0.ballsAmount > $1.ballsAmount })
    }
    
    func getAttackingStations(enemysBalls: Int) -> [Station] {
        let myStations = getSortedStation()
        var total = 0
        for station in myStations {
            total += station.ballsAmount
            if total > enemysBalls {
                return myStations
            }
        }
        return myStations
    }
    
    override func attack(station: Station) {
        if makeDecision() {
            if station.ballsAmount + 5 < getAllBalls() {
                
                let stationsPreppedForAttack: [Station] = getAttackingStations(enemysBalls: station.ballsAmount + 5)
                for i in stationsPreppedForAttack {
                    mover?.move(from: i, to: station, by: self)
                }
            }
        }
    }
}
