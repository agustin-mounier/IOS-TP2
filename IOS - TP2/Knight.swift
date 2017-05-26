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
    
    init(map: SKTileMapNode) {
        super.init(map: map, textureName: "knight")
        self.position = CGPoint(x: 200, y:200)
        AStar = AStarAlgorithm(map: map)
        PLAYER_SPEED = CGFloat(10)
        steerProtocol = PathFollowingSteering()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func goTo(point: CGPoint) {
        let positionInMap = position.toMapCoords(map: map)
        
        if positionInMap.equalTo(point) {
            return
        }
        
        let path = AStar.getPath(from: positionInMap, to: point)
        (steerProtocol as! PathFollowingSteering).setPath(path: path)
        moving = true
        move()
    }
    
    
    
    
}
