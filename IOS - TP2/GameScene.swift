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
    
    var map:  GameMap!
    var cam: SKCameraNode!
    var knight: Knight!
    var cyclops = [Cyclop]()
    
    let camScale = CGFloat(2.5)
    let CYCLOPS_COUNT = 2
    
    var lastTime = 0.0
    
    var players = [Player]()
    let fireSwordNode = SKSpriteNode()

    var HPLabel : SKLabelNode!
    var attackPointsLabels: SKLabelNode!
    
    override func didMove(to view: SKView) {
        map = GameMap(map: (scene?.childNode(withName:"Map"))! as! SKTileMapNode, players: players)
        knight = Knight(map: map)
        
        cam = SKCameraNode()
        cam.setScale(camScale)
        camera = cam
        cam.position = knight.position
        
        if CYCLOPS_COUNT > 0 {
        for i in 0...CYCLOPS_COUNT-1 {
            let cyclop = Cyclop(map: map, knight: knight)
            cyclops.append(cyclop)
            addChild(cyclops[i])
            players.append(cyclop)
        }
        }
        addChild(knight)
        addChild(cam)
        players.append(knight)
        
        let fireSwordAnimation = FireSwordAnimation.create()

        fireSwordNode.position = CGPoint(x:3, y:18).toScreenCoords(map: map)
        fireSwordNode.size = map.tileSize
        fireSwordNode.run(SKAction.repeatForever(fireSwordAnimation))
        addChild(fireSwordNode)
        
        HPLabel = SKLabelNode(text: "HP: \(knight.hp!)")
        attackPointsLabels = SKLabelNode(text: "Attack points: \(knight.damage)")
        
        HPLabel.fontColor = UIColor.black
        attackPointsLabels.fontColor = UIColor.black
        
        addChild(HPLabel)
        addChild(attackPointsLabels)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        
        let cyclopTapped = cyclopTap(point: touchLocation)
        
        if cyclopTapped == nil {
            if map.waterTiles.contains(touchLocation.toMapCoords(map: map)) {
                return;
            }
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
                if player is Knight &&
                    player.position.toMapCoords(map: map).equalTo(CGPoint(x:3, y:18)) {
                    (player as! Knight).hasFireSword = true
                    fireSwordNode.removeFromParent()
                }
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
        
        handleCam()
        updateMenu()
    }
    
    func cyclopTap(point: CGPoint) -> Cyclop? {
        
        let pointCoords = point.toMapCoords(map: map)
        
        if CYCLOPS_COUNT > 0 {
        for i in 0...CYCLOPS_COUNT-1 {
            if pointCoords.equalTo(cyclops[i].position.toMapCoords(map: map)) {
                return cyclops[i]
            }
        }
        }
        return nil
    }
    
    func handleCam () {
        let knightPosition = knight.position.toMapCoords(map: map)
        
        if knightPosition.y >= 13 && knightPosition.y <= 14 {
            cam.position.x = knight.position.x
            HPLabel.position.x = knight.position.x + 750
            attackPointsLabels.position.x = knight.position.x + 500
        }
        
        if knightPosition.x >= 5 && knightPosition.x <= 15 {
            cam.position.y = knight.position.y
            HPLabel.position.y = knight.position.y + 450
            attackPointsLabels.position.y = knight.position.y + 450
        }
    }
  
    
    func updateMenu() {
        HPLabel.text = "HP: \(knight.hp!)"
        if knight.hasFireSword {
            attackPointsLabels.text = "Attack points: \(knight.fireDamage)"
        } else {
            attackPointsLabels.text = "Attack points: \(knight.damage)"
        }
    }

}
