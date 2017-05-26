//
//  Cyclop.swift
//  IOS - TP2
//
//  Created by Agustin Mounier on 5/25/17.
//  Copyright © 2017 Agustin Mounier. All rights reserved.
//

import UIKit
import SpriteKit

class Cyclop: Player {
    
    init(map: SKTileMapNode) {
        super.init(map: map, textureName: "cyclop")
        let row = random(max: map.numberOfRows)
        let column = random(max: map.numberOfColumns)
        self.position = map.centerOfTile(atColumn: column, row: row)
        steerProtocol = WondererSteering(map: map, lastTile: CGPoint(x: row, y: column))
        PLAYER_SPEED = CGFloat(8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func explore() {
    
    }
    
    func random(max maxNumber: Int) -> Int {
        return Int(arc4random_uniform(UInt32(maxNumber)))
    }
    
}
