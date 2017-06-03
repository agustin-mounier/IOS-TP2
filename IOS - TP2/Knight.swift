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
    
    init(map: SKTileMapNode) {
        super.init(map: map, textureName: "knight")
        self.position = CGPoint(x: 200, y:200)
        AStar = AStarAlgorithm(map: map)
        PLAYER_SPEED = CGFloat(10)
        steerProtocol = PathFollowingSteering()
        let blood = BloodAnimation.create(subject:  self)

        self.run(SKAction.repeatForever(blood))
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
        target.selected = true
        target.updateTexture(textureName: target.textureName)
        steerProtocol = PersuitSteering(map: map, lastTile: position.toMapCoords(map: map), objective: objective)
        
        
    }
    

}
