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
        return [true, false, false].randomElement()!
    }
    
    func findStationToAttack(stations: [Station]) -> Station? {
        guard let station = stations.filter({ $0.owner != self.type && $0.type == .active }).randomElement()
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
        var atackingStations = [Station]()
        var total = 0
        for station in myStations {
            total += station.ballsAmount
            atackingStations.append(station)
            if total > enemysBalls {
                return atackingStations
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
