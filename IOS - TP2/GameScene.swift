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
    let CYCLOPS_COUNT = 1
    
    override func didMove(to view: SKView) {
        map = (scene?.childNode(withName:"Map"))! as! SKTileMapNode
        knight = Knight(map: map)
        
        cam = SKCameraNode()
        cam.setScale(camScale)
        camera = cam
        cam.position = knight.position
        
        for i in 1...CYCLOPS_COUNT {
            cyclops.append(Cyclop(map: map, knight: knight))
            addChild(cyclops[i - 1])
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
        
        let cyclopTapped = cyclopTap(point: touchLocation)
        
        if cyclopTapped == nil {
            knight.goTo(point: touchLocation.toMapCoords(map: map))
        } else {
            knight.kill(objective: cyclopTapped!)
        }
        
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if knight.moving {
            knight.move()
        }
        
        for i in 1...CYCLOPS_COUNT {
            if cyclops[i - 1].moving {
                cyclops[i - 1].move()
            }
            cyclops[i - 1].scanForKnight()
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
