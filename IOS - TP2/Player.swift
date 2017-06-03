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
    var moving = false

    var direction: CGPoint!
    var map: SKTileMapNode!
    var PLAYER_SPEED = CGFloat(10)
    var steerProtocol: SteeringProtocol!
    var nextInPath: CGPoint!
    var textureName: String!
    var selected = false
    
    var hp: Int!
    
    init(map: SKTileMapNode, textureName: String) {
        let texture = SKTexture(imageNamed: "\(textureName)_down")
        super.init(texture: texture, color: UIColor.clear, size: map.tileSize)
        self.position = CGPoint(x: 200, y:200)
        self.map = map
        self.textureName = textureName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move() {
        
        if nextInPath == nil {
            nextInPath = steerProtocol.steer()
            direction = (position.toMapCoords(map: map) - nextInPath!) * -1
            updateTexture(textureName: textureName)
        }
        
        position = position + (direction.reverse() * PLAYER_SPEED)
        let distanceToCenter = position - (nextInPath?.toScreenCoords(map: map))!
        
        if abs(distanceToCenter.x) < PLAYER_SPEED && abs(distanceToCenter.y) < PLAYER_SPEED {
            position = (nextInPath?.toScreenCoords(map: map))!
            
            if(steerProtocol.steeringEnded()){
                moving = false
                nextInPath = nil
            } else {
                nextInPath = steerProtocol.steer()
                direction = (position.toMapCoords(map: map) - nextInPath!) * -1
                updateTexture(textureName: textureName)
            }
        }
        
    }
    
    func updateTexture(textureName: String) {
        if direction.equalTo(CGPoint(x: -1, y: 0)) {
            if selected {
                texture = SKTexture(imageNamed: "\(textureName)_down_selected")
            } else {
                texture = SKTexture(imageNamed: "\(textureName)_down")
            }
        } else if direction.equalTo(CGPoint(x: 1, y: 0)) {
            if selected {
                texture = SKTexture(imageNamed: "\(textureName)_up_selected")
            } else {
                texture = SKTexture(imageNamed: "\(textureName)_up")
            }
        } else if direction.equalTo(CGPoint(x: 0, y: 1)) {
            if selected {
                texture = SKTexture(imageNamed: "\(textureName)_right_selected")
            } else {
                texture = SKTexture(imageNamed: "\(textureName)_right")
            }
        } else if direction.equalTo(CGPoint(x: 0, y: -1)) {
            if selected {
                texture = SKTexture(imageNamed: "\(textureName)_left_selected")
            } else {
                texture = SKTexture(imageNamed: "\(textureName)_left")
            }
        }
    }
}
