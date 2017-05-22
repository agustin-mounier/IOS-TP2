//
//  CGPointExtension.swift
//  IOS - TP2
//
//  Created by Agustin Mounier on 5/11/17.
//  Copyright © 2017 Agustin Mounier. All rights reserved.
//

import UIKit
import SpriteKit
extension CGPoint: Hashable {
    public var hashValue: Int {
        return hash()
    }
    
    func hash() -> Int {
        var hash = 23
        hash = hash &* 31 &+ Int(self.x)
        return hash &* 31 &+ Int(self.y)
    }
    
    func toMapCoords(map: SKTileMapNode) -> CGPoint {
        let row = map.tileRowIndex(fromPosition: self)
        let column = map.tileColumnIndex(fromPosition: self)
        return CGPoint(x: row, y: column)
    }
    
    func toScreenCoords(map: SKTileMapNode) -> CGPoint {
        return map.centerOfTile(atColumn: Int(y), row: Int(x))
    }
    
    func reverse() -> CGPoint {
        return CGPoint(x: y, y: x)
    }
    
    static public func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    static public func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static public func * (left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x * right, y: left.y * right)
    }
}
