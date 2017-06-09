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
    var map: SKTileMapNode!
    var path = [CGPoint]()
    var lastTile: CGPoint!
    
    init(map: SKTileMapNode, lastTile: CGPoint, players: [Player]) {
        self.AStar = AStarAlgorithm(map: map, players: players)
        self.map = map
        self.lastTile = lastTile
    }
    
    func steer() -> CGPoint {
        if path.isEmpty {
            let row = random(max: map.numberOfRows)
            let column = random(max: map.numberOfColumns)
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
