//
//  Knight.swift
//  IOS - TP2
//
//  Created by Agustin Mounier on 5/25/17.
//  Copyright © 2017 Agustin Mounier. All rights reserved.
//

import UIKit
import SpriteKit

class Knight: Player {

    var AStar: AStarAlgorithm!
    var target: Player!
    let fireDamage = CGFloat(20)
    var hasFireSword = false
    
    init(map: GameMap) {
        super.init(map: map, textureName: "knight")
        self.position = CGPoint(x: 600, y:500)
        AStar = AStarAlgorithm(map: map)
        PLAYER_SPEED = CGFloat(10)
        steerProtocol = PathFollowingSteering()
        hp = CGFloat(250)
        damage = CGFloat(10)
        hitPerSecond = 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func goTo(point: CGPoint) {
        if !(steerProtocol is PathFollowingSteering) {
            steerProtocol = PathFollowingSteering()
            target.selected = false
        }
        
        let positionInMap = position.toMapCoords(map: map)
        
        if positionInMap.equalTo(point) {
            return
        }
        
        let path = AStar.getPath(from: positionInMap, to: point)

        (steerProtocol as! PathFollowingSteering).setPath(path: path)
        moving = true
        move()
    }
    
    func kill(objective: Player) {
        target = objective
        steerProtocol = PersuitSteering(map: map, lastTile: position.toMapCoords(map: map), objective: objective)
        
        state = State.ATTACKING
    }
    
    override func attack() {
        
        let targetPosition = target.position.toMapCoords(map: map)
        let currentPosition = position.toMapCoords(map: map)
        
        if distBetween(from: currentPosition, to: targetPosition) <= 2 {
        if hasFireSword {
            target.reciveFireDamage(damage: fireDamage)
        } else {
            target.reciveDamage(damage: damage)
        }
        }
        if target.state == State.DEAD {
            state = State.WONDERING
        }
    }

}
