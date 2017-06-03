//
//  Cyclop.swift
//  IOS - TP2
//
//  Created by Agustin Mounier on 5/25/17.
//  Copyright © 2017 Agustin Mounier. All rights reserved.
//

import UIKit
import SpriteKit

class Cyclop: Player {
    
    let VIEW_DISTANCE = CGFloat(60)
    var knight: Knight!
    
    init(map: SKTileMapNode, knight: Knight) {
        super.init(map: map, textureName: "cyclop")
        let row = random(max: map.numberOfRows)
        let column = random(max: map.numberOfColumns)
        self.position = map.centerOfTile(atColumn: column, row: row)
        self.knight = knight
        steerProtocol = WondererSteering(map: map, lastTile: CGPoint(x: row, y: column))
        PLAYER_SPEED = CGFloat(8)
        moving = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scanForKnight() {
        
        if steerProtocol is PersuitSteering { return }
        
        let currentPosition = position.toMapCoords(map: map)
        let knightPosition = knight.position.toMapCoords(map: map)
        if distBetween(from: currentPosition, to: knightPosition) <= VIEW_DISTANCE {
            nextInPath = nil
            self.steerProtocol = PersuitSteering(map: map, lastTile: currentPosition, objective: knight)
        }
    }
    
    func distBetween(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(pow(from.x - to.x, 2) + pow(from.y - to.y, 2))
    }
    
    func random(max maxNumber: Int) -> Int {
        return Int(arc4random_uniform(UInt32(maxNumber)))
    }
    
}
