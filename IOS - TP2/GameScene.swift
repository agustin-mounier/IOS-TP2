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
    var player: Player!
    
    let camScale = CGFloat(2.0)
    
    override func didMove(to view: SKView) {
        map = (scene?.childNode(withName:"Map"))! as! SKTileMapNode
        player = Player(map: map)
        
        cam = SKCameraNode()
        cam.setScale(camScale)
        camera = cam
        cam.position = player.position
        
        addChild(player)
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
        
        player.goTo(point: touchLocation.toMapCoords(map: map))
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if player.moving {
            player.move()
        }
        cam.position = player.position
    }
}
