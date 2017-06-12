//
//  GameMap.swift
//  IOS - TP2
//
//  Created by Agustin Mounier on 6/9/17.
//  Copyright © 2017 Agustin Mounier. All rights reserved.
//

import UIKit
import SpriteKit

class GameMap: SKTileMapNode {

    var players: [Player]!
    var waterTiles = [CGPoint]()
    
    init(map: SKTileMapNode, players: [Player]) {
        self.players = players
        var tileGroups = [SKTileGroup]()
        for row in 0...map.numberOfRows-1 {
            for column in 0...map.numberOfColumns-1 {
                tileGroups.append(map.tileGroup(atColumn: column, row: row)!)
            }
        }
        
        waterTiles.append(CGPoint(x: 6, y: 14))
        waterTiles.append(CGPoint(x: 6, y: 13))
        waterTiles.append(CGPoint(x: 6, y: 12))
        waterTiles.append(CGPoint(x: 6, y: 11))
        waterTiles.append(CGPoint(x: 6, y: 10))
        waterTiles.append(CGPoint(x: 5, y: 10))
        waterTiles.append(CGPoint(x: 5, y: 11))
        waterTiles.append(CGPoint(x: 5, y: 12))
        waterTiles.append(CGPoint(x: 5, y: 13))
        waterTiles.append(CGPoint(x: 4, y: 13))
        waterTiles.append(CGPoint(x: 4, y: 12))
        waterTiles.append(CGPoint(x: 12, y: 15))
        waterTiles.append(CGPoint(x: 13, y: 15))
        waterTiles.append(CGPoint(x: 14, y: 15))
        waterTiles.append(CGPoint(x: 14, y: 16))
        waterTiles.append(CGPoint(x: 14, y: 17))
        waterTiles.append(CGPoint(x: 13, y: 17))
        waterTiles.append(CGPoint(x: 12, y: 17))
        waterTiles.append(CGPoint(x: 12, y: 16))
        waterTiles.append(CGPoint(x: 13, y: 16))

        
        super.init(tileSet: map.tileSet, columns: map.numberOfColumns, rows: map.numberOfRows, tileSize: map.tileSize, tileGroupLayout: tileGroups)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
