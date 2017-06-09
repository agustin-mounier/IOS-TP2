//
//  PersuitSteering.swift
//  IOS - TP2
//
//  Created by Agustin Mounier on 6/2/17.
//  Copyright © 2017 Agustin Mounier. All rights reserved.
//

import UIKit
import SpriteKit

class PersuitSteering: NSObject, SteeringProtocol {
    
    var AStar: AStarAlgorithm!
    var map: GameMap!
    var path = [CGPoint]()
    var lastTile: CGPoint!
    var objective: SKSpriteNode!
    var lastObjectiveTile: CGPoint!
    
    init(map: GameMap, lastTile: CGPoint, objective: SKSpriteNode) {
        self.AStar = AStarAlgorithm(map: map)
        self.map = map
        self.lastTile = lastTile
        self.objective = objective
        self.lastObjectiveTile = objective.position.toMapCoords(map: map)
        path = AStar.getPath(from: lastTile, to: lastObjectiveTile)
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func steer() -> CGPoint {
        let objectiveCoords = objective.position.toMapCoords(map: map)
        
        if !lastObjectiveTile.equalTo(objectiveCoords) {
            path = AStar.getPath(from: lastTile, to: objectiveCoords)
            lastObjectiveTile = objectiveCoords
            if !path.isEmpty {
                path.removeLast()
            }
        }
        
        if path.isEmpty {
            return lastTile
        }
        
        lastTile = path.remove(at: 0)
        
        return lastTile
    }
    
    func steeringEnded() -> Bool {
        return false
    }
    
    
    func random(max maxNumber: Int) -> Int {
        return Int(arc4random_uniform(UInt32(maxNumber)))
    }
}
