//
//  Player.swift
//  IOS - TP2
//
//  Created by Agustin Mounier on 5/21/17.
//  Copyright © 2017 Agustin Mounier. All rights reserved.
//

import UIKit
import SpriteKit

class Player: SKSpriteNode {
    var AStar: AStarAlgorithm!
    var moving = false
    var movingPath = [CGPoint]()
    var nextInPath: CGPoint?
    var direction: CGPoint!
    
    var map: SKTileMapNode!
    
    let PLAYER_SPEED = CGFloat(10)
    
    init(map: SKTileMapNode) {
        let texture = SKTexture(imageNamed: "knight_down")
        super.init(texture: texture, color: UIColor.clear, size: map.tileSize)
        self.position = CGPoint(x: 200, y:200)
        AStar = AStarAlgorithm(map: map)
        self.map = map
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func goTo(point: CGPoint) {
        let positionInMap = position.toMapCoords(map: map)
        
        if positionInMap.equalTo(point) {
            return
        }
        
        movingPath = AStar.getPath(from: positionInMap, to: point)
        moving = true
        move()
    }
    
    func move() {
        if nextInPath == nil {
            nextInPath = movingPath.remove(at: 0)
            direction = (position.toMapCoords(map: map) - nextInPath!) * -1
            updateTexture()
        }
        
        position = position + (direction.reverse() * PLAYER_SPEED)
        let distanceToCenter = position - (nextInPath?.toScreenCoords(map: map))!
        
        if abs(distanceToCenter.x) < PLAYER_SPEED && abs(distanceToCenter.y) < PLAYER_SPEED {
            position = (nextInPath?.toScreenCoords(map: map))!
            
            if(movingPath.isEmpty){
                moving = false
                nextInPath = nil
            } else {
                nextInPath = movingPath.remove(at: 0)
                direction = (position.toMapCoords(map: map) - nextInPath!) * -1
                updateTexture()
            }
        }
        
    }
    
    func updateTexture() {
        if direction.equalTo(CGPoint(x: -1, y: 0)) {
            texture = SKTexture(imageNamed: "knight_down")
        } else if direction.equalTo(CGPoint(x: 1, y: 0)) {
            texture = SKTexture(imageNamed: "knight_up")
        } else if direction.equalTo(CGPoint(x: 0, y: 1)) {
            texture = SKTexture(imageNamed: "knight_right")
        } else if direction.equalTo(CGPoint(x: 0, y: -1)) {
            texture = SKTexture(imageNamed: "knight_left")
        }
    }
}
