//
//  WondererSteering.swift
//  IOS - TP2
//
//  Created by Agustin Mounier on 5/25/17.
//  Copyright © 2017 Agustin Mounier. All rights reserved.
//

import UIKit
import SpriteKit

class WondererSteering: NSObject, SteeringProtocol {

    var AStar: AStarAlgorithm!
    var map: GameMap!
    var path = [CGPoint]()
    var lastTile: CGPoint!
    
    init(map: GameMap, lastTile: CGPoint) {
        self.AStar = AStarAlgorithm(map: map)
        self.map = map
        self.lastTile = lastTile
    }
    
    func steer() -> CGPoint {
        if path.isEmpty {
            var row: Int
            var column: Int
            repeat {
                row = random(max: map.numberOfRows-1)
                column = random(max: map.numberOfColumns-1)
            } while !(map.tileDefinition(atColumn: column, row: row)?.name?.hasPrefix("water_sand"))!
            
            path = AStar.getPath(from: lastTile, to: CGPoint(x: row, y: column))
        }
        if !path.isEmpty {
            lastTile = path.remove(at: 0)
        }
        return lastTile
    }
    
    func steeringEnded() -> Bool {
        return false
    }
    
    
    func random(max maxNumber: Int) -> Int {
        return Int(arc4random_uniform(UInt32(maxNumber)))
    }
}
