//
//  GameScene.swift
//  IOS - TP2
//
//  Created by Agustin Mounier on 5/11/17.
//  Copyright © 2017 Agustin Mounier. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var map:  SKTileMapNode!
    var cam: SKCameraNode!
    var knight: Knight!
    var cyclops = [Cyclop]()
    
    let camScale = CGFloat(2.0)
    
    override func didMove(to view: SKView) {
        map = (scene?.childNode(withName:"Map"))! as! SKTileMapNode
        knight = Knight(map: map)
        
        cam = SKCameraNode()
        cam.setScale(camScale)
        camera = cam
        cam.position = knight.position
        
        for i in 0...4 {
            cyclops.append(Cyclop(map: map))
            addChild(cyclops[i-1])
        }
        
        addChild(knight)
        addChild(cam)
    
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else {
//            return
//        }
        
//        let touchLocation = touch.location(in: self)
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        
        knight.goTo(point: touchLocation.toMapCoords(map: map))
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if knight.moving {
            knight.move()
        }
        
        for i in 0...4 {
            cyclops[i].move()
        }
        
        cam.position = knight.position
    }
}
