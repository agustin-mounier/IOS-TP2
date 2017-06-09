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
    var waterTiles: [NSObject]!
    
    init(map: SKTileMapNode, players: [Player]) {
        self.players = players
        var tileGroups = [SKTileGroup]()
        for row in 0...map.numberOfRows {
            for column in 0...map.numberOfColumns {
                let tileDef = map.tileDefinition(atColumn: column, row: row)
                for texture in (tileDef?.textures)! {
                    print(texture.description)
                }
                tileGroups.append(map.tileGroup(atColumn: column, row: row)!)
            }
        }
        super.init(tileSet: map.tileSet, columns: map.numberOfColumns, rows: map.numberOfRows, tileSize: map.tileSize, tileGroupLayout: tileGroups)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
