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
    
    enum State {case ATTACKING, WONDERING, DEAD}
    var moving = false

    var direction: CGPoint!
    var map: GameMap!
    var PLAYER_SPEED = CGFloat(10)
    var steerProtocol: SteeringProtocol!
    var nextInPath: CGPoint!
    var textureName: String!
    var selected = false
    var state = State.WONDERING
    
    var hp: CGFloat!
    var damage = CGFloat(0)
    
    var timeToAttack = 0.0
    var hitPerSecond = 0.0
    
    let safeCheck = CGPoint()


    init(map: GameMap, textureName: String) {
        let texture = SKTexture(imageNamed: "\(textureName)_down")
        super.init(texture: texture, color: UIColor.clear, size: map.tileSize)
        self.position = CGPoint(x: 200, y:200)
        self.map = map
        self.textureName = textureName
        hp = CGFloat(0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move() {
        if state == State.DEAD {
            return;
        }
        
        if nextInPath == nil {
            nextInPath = steerProtocol.steer()
            direction = (position.toMapCoords(map: map) - nextInPath!) * -1
        }
        
        if nextInPath == safeCheck {
            moving = false
        }
        
        position = position + (direction.reverse() * PLAYER_SPEED)
        let distanceToCenter = position - (nextInPath?.toScreenCoords(map: map))!
        
        if abs(distanceToCenter.x) < PLAYER_SPEED*2 && abs(distanceToCenter.y) < PLAYER_SPEED*2 {
            position = (nextInPath?.toScreenCoords(map: map))!
            
            if(steerProtocol.steeringEnded()){
                moving = false
                nextInPath = nil
            } else {
                nextInPath = steerProtocol.steer()
                direction = (position.toMapCoords(map: map) - nextInPath!) * -1
            }
        }
        
    }
    
    func updateTexture() {
        if state == State.DEAD {
            texture = SKTexture(imageNamed: "Dead_Body")
            return;
        }
        
        if direction != nil {
        if direction.equalTo(CGPoint(x: -1, y: 0)) {
            if selected {
                texture = SKTexture(imageNamed: "\(textureName!)_down_selected")
            } else {
                texture = SKTexture(imageNamed: "\(textureName!)_down")
            }
        } else if direction.equalTo(CGPoint(x: 1, y: 0)) {
            if selected {
                texture = SKTexture(imageNamed: "\(textureName!)_up_selected")
            } else {
                texture = SKTexture(imageNamed: "\(textureName!)_up")
            }
        } else if direction.equalTo(CGPoint(x: 0, y: 1)) {
            if selected {
                texture = SKTexture(imageNamed: "\(textureName!)_right_selected")
            } else {
                texture = SKTexture(imageNamed: "\(textureName!)_right")
            }
        } else if direction.equalTo(CGPoint(x: 0, y: -1)) {
            if selected {
                texture = SKTexture(imageNamed: "\(textureName!)_left_selected")
            } else {
                texture = SKTexture(imageNamed: "\(textureName!)_left")
            }
        }
        }
    }
    
    func reciveDamage(damage: CGFloat) {
        hp = hp - damage
        let blood = BloodAnimation.create(subject:  self)
        self.run(blood)
        if(hp <= 0) {
            state = State.DEAD
        }
    }
    
    func attack() {}
    
    func wonder() {}
    
    func attackHandler(time: Double) {
        timeToAttack += time
        
        if (timeToAttack >= hitPerSecond) {
            attack()
            timeToAttack = 0.0
        }
    }
    
    func distBetween(from: CGPoint, to: CGPoint) -> CGFloat {
        return abs(from.x - to.x) + abs(from.y - to.y)
    }
    
    func sqDistBetween(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(pow(from.x - to.x, 2) + pow(from.y - to.y, 2))
    }

}
