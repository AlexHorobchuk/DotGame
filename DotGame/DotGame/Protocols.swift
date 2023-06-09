//
//  Protocols.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/28/23.
//

import Foundation

protocol MoverService: AnyObject {
    
    func move(from stationA: Station, to stationB: Station, by participator: Participator)
}

