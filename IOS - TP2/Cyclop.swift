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
    
    let VIEW_DISTANCE = CGFloat(4)
    var knight: Knight!
    
    init(map: GameMap, knight: Knight) {
        super.init(map: map, textureName: "cyclop")
        var row: Int
        var column: Int
        repeat {
            row = random(max: map.numberOfRows-1)
            column = random(max: map.numberOfColumns-1)
        } while !(map.tileDefinition(atColumn: column, row: row)?.name?.hasPrefix("water_sand"))!
        self.position = map.centerOfTile(atColumn: column, row: row)
        self.knight = knight
        steerProtocol = WondererSteering(map: map, lastTile: CGPoint(x: row, y: column))
        PLAYER_SPEED = CGFloat(8)
        hp = CGFloat(100)
        damage = CGFloat(8)
        hitPerSecond = 1.5
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
            state = State.ATTACKING
        }
    }
    
    override func wonder() {
        scanForKnight()
    }
    
    func random(max maxNumber: Int) -> Int {
        return Int(arc4random_uniform(UInt32(maxNumber)))
    }
    
    override func attack() {
        let currentPosition = position.toMapCoords(map: map)
        let knightPosition = knight.position.toMapCoords(map: map)
        
        if distBetween(from: currentPosition, to: knightPosition) <= 2 {
            knight.reciveDamage(damage: damage)
            if knight.state == State.DEAD {
                state = State.WONDERING
            }
        }
    }

}
