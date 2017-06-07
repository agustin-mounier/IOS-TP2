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
    let CYCLOPS_COUNT = 5
    
    var lastTime = 0.0
    
    var players = [Player]()
    
    override func didMove(to view: SKView) {
        map = (scene?.childNode(withName:"Map"))! as! SKTileMapNode
        knight = Knight(map: map)
        
        cam = SKCameraNode()
        cam.setScale(camScale)
        camera = cam
        cam.position = knight.position
        
        for i in 1...CYCLOPS_COUNT {
            let cyclop = Cyclop(map: map, knight: knight)
            cyclops.append(cyclop)
            addChild(cyclops[i - 1])
            players.append(cyclop)
        }
        addChild(knight)
        addChild(cam)
        players.append(knight)
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
        
        let cyclopTapped = cyclopTap(point: touchLocation)
        
        if cyclopTapped == nil {
            knight.goTo(point: touchLocation.toMapCoords(map: map))
        } else {
            cyclopTapped?.selected = true
            knight.kill(objective: cyclopTapped!)
        }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        let timePassed = currentTime - lastTime
        lastTime = currentTime

        
        for player in players {
            player.updateTexture()
            
            if player.moving && player.state != Player.State.DEAD {
                player.move()
            }
            
            switch player.state {
            case Player.State.ATTACKING:
                player.attackHandler(time: timePassed)
                break
            case Player.State.WONDERING:
                player.wonder()
                break
            case Player.State.DEAD:
                break
            }
        }
        
        cam.position = knight.position
    }
    
    func cyclopTap(point: CGPoint) -> Cyclop? {
        
        let pointCoords = point.toMapCoords(map: map)
        
        for i in 1...CYCLOPS_COUNT {
            if pointCoords.equalTo(cyclops[i - 1].position.toMapCoords(map: map)) {
                return cyclops[i - 1]
            }
        }
        
        return nil
    }
}
