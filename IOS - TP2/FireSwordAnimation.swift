//
//  FireSwordAnimation.swift
//  IOS - TP2
//
//  Created by Agustin Mounier on 6/11/17.
//  Copyright © 2017 Agustin Mounier. All rights reserved.
//

import UIKit
import SpriteKit

class FireSwordAnimation: NSObject {
    
    static func create() -> SKAction {
        
        let sand = SKTexture(imageNamed: "Sand_Grid_Center")
        
        let blood0 = SKSpriteNode(imageNamed:"Fire_Sword-0")
        let blood1 = SKSpriteNode(imageNamed:"Fire_Sword-1")
        
        blood0.size = sand.size()
        blood1.size = sand.size()
        
        let subject = SKSpriteNode(texture: sand)
        
        let texturesNodes = [blood0, blood1]
        
        var animationTextures = [SKTexture]()
        
        let view = SKView()
        
        for tNode in texturesNodes {
            let container = SKNode()
            subject.zPosition = -1.0
            tNode.zPosition = 1.0
            container.addChild(subject)
            container.addChild(tNode)
            
            animationTextures.append(view.texture(from: container)!)
        }
        
        return SKAction.animate(with: animationTextures, timePerFrame: 0.3)
    }


}
