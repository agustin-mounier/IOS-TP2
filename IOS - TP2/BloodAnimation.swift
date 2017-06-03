//
//  HitAnimation.swift
//  IOS - TP2
//
//  Created by Agustin Mounier on 6/3/17.
//  Copyright © 2017 Agustin Mounier. All rights reserved.
//

import UIKit
import SpriteKit

class BloodAnimation: NSObject {

    static func create(subject: Player) -> SKAction {
    
        let blood0 = SKSpriteNode(imageNamed:"blood-0")
        let blood1 = SKSpriteNode(imageNamed:"blood-1")
        let blood2 = SKSpriteNode(imageNamed:"blood-2")
        let blood3 = SKSpriteNode(imageNamed:"blood-3")
        let blood4 = SKSpriteNode(imageNamed:"blood-4")
        let blood5 = SKSpriteNode(imageNamed:"blood-5")
        let blood6 = SKSpriteNode(imageNamed:"blood-6")
        
        let subject = SKSpriteNode(texture: subject.texture)

        let texturesNodes = [blood0, blood1, blood2, blood3, blood4, blood5, blood6]
        
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
