//
//  FireAnimation.swift
//  IOS - TP2
//
//  Created by Agustin Mounier on 6/11/17.
//  Copyright © 2017 Agustin Mounier. All rights reserved.
//

import UIKit
import SpriteKit

class FireAnimation: NSObject {
    
    static func create(subject: Player) -> SKAction {
        
        let blood0 = SKSpriteNode(imageNamed:"Fire_Effect-0")
        let blood1 = SKSpriteNode(imageNamed:"Fire_Effect-1")
        let blood2 = SKSpriteNode(imageNamed:"Fire_Effect-2")
        let blood3 = SKSpriteNode(imageNamed:"Fire_Effect-3")
        let blood4 = SKSpriteNode(imageNamed:"Fire_Effect-4")
        let blood5 = SKSpriteNode(imageNamed:"Fire_Effect-5")
        let blood6 = SKSpriteNode(imageNamed:"Fire_Effect-6")
        let blood7 = SKSpriteNode(imageNamed:"Fire_Effect-7")
        let blood8 = SKSpriteNode(imageNamed:"Fire_Effect-8")
        let blood9 = SKSpriteNode(imageNamed:"Fire_Effect-9")


        
        let subject = SKSpriteNode(texture: subject.texture)
        
        let texturesNodes = [blood0, blood1, blood2, blood3, blood4, blood5, blood6, blood7, blood8, blood9]
        
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
        
        return SKAction.animate(with: animationTextures, timePerFrame: 0.07)
    }
    

}
