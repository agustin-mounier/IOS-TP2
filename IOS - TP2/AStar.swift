//
//  AStar.swift
//  IOS - TP2
//
//  Created by Agustin Mounier on 5/11/17.
//  Copyright © 2017 Agustin Mounier. All rights reserved.
//

import UIKit
import SpriteKit


class AStarAlgorithm: NSObject {
    
    var gameMap: GameMap!
    var openSet = Set<CGPoint>()
    var closedSet = Set<CGPoint>()
    var cameFrom = [CGPoint: CGPoint]()
    var gScore = [CGPoint: CGFloat]()
    var fScore = [CGPoint: CGFloat]()
    
    init(map: GameMap) {
        self.gameMap = map
    }
    
    func getPath(from: CGPoint, to: CGPoint) -> [CGPoint] {
        reset()
        openSet.insert(from)
        gScore[from] = 0
        fScore[from] = heuristic(from: from, to: to)
        
        while !openSet.isEmpty {
            let current = getLowestFScorePoint()
            
            if (current?.equalTo(to))! {
                return reconstructPath(current: current!)
            }
            
            openSet.remove(current!)
            closedSet.insert(current!)
            
            for neighbour in getNeighbours(of: current!) {
                
                if closedSet.contains(neighbour) {
                    continue
                }
                
                let tentative_gScore = gScore[current!]! + distBetween(from: current!, to: neighbour)
                
                if !openSet.contains(neighbour) {
                    openSet.insert(neighbour)
                } else if tentative_gScore >= gScore[neighbour]! {
                    continue
                }
            
                cameFrom[neighbour] = current
                gScore[neighbour] = tentative_gScore
                fScore[neighbour] = tentative_gScore + heuristic(from: neighbour, to: to)
            }
        }
        
        return [CGPoint]()
    }
    
    func distBetween(from: CGPoint, to: CGPoint) -> CGFloat {
        return abs(from.x - to.x) + abs(from.y - to.y)
    }
    
    func heuristic(from: CGPoint, to: CGPoint) -> CGFloat {
        
        
//        for waterTile in gameMap.waterTiles {
//            if intersectsTile(p1: from.toScreenCoords(map: gameMap), p2: to.toScreenCoords(map: gameMap), tileCenter: CGPoint(x: waterTile.getRow(), y: waterTile.getCol()).toScreenCoords(map: gameMap)) {
//                return CGFloat.infinity
//            }
//        }
        
        return sqrt(pow(from.x - to.x, 2) + pow(from.y - to.y, 2))
    }
    
    
    func reset() {
        openSet.removeAll()
        closedSet.removeAll()
        cameFrom.removeAll()
        gScore.removeAll()
        fScore.removeAll()
    }
    
    func getLowestFScorePoint() -> CGPoint? {
        return openSet.min(by: { (a : CGPoint, b : CGPoint) -> Bool in
            return fScore[a]! < fScore[b]!
        })
    }
    
    func reconstructPath(current: CGPoint) -> [CGPoint] {
        var path = [current]
        var pathPoint = current
        
        while cameFrom.keys.contains(pathPoint) {
            pathPoint = cameFrom[pathPoint]!
            path.insert(pathPoint, at: 0)
        }
        path.remove(at: 0)
        return path
    
    }
    
    func getNeighbours(of: CGPoint) -> [CGPoint] {
        
        var neighbours = [CGPoint]()
        
        for i in -1...1 {
            for j in -1...1 {
                let point = CGPoint(x: of.x + CGFloat(i),y: of.y + CGFloat(j))
                
                if gameMap.contains(point) {
                    neighbours.append(point)
                }
            }
        }
        
        return neighbours
    }
    
    func intersectsTile(p1: CGPoint, p2: CGPoint, tileCenter: CGPoint) -> Bool {
        let tileWidth = gameMap.tileSize.width
        let tileHeight = gameMap.tileSize.height
        
        let upperLeftCornerX = tileCenter.x - tileWidth/2
        let upperLeftCornerY = tileCenter.y + tileHeight/2
        
        let upperRightCornerX = tileCenter.x + tileWidth/2
        let upperRightCornerY = upperLeftCornerY
        
        let bottomLeftCornerX = upperLeftCornerX
        let bottomLeftCornerY = tileCenter.y - tileHeight/2
        
        let bottomRightCornerX = upperRightCornerX
        let bottomRightCornerY = bottomLeftCornerY
        
        return lineIntersecsLine(p1, p2, CGPoint(x: upperLeftCornerX, y: upperLeftCornerY), CGPoint(x: upperRightCornerX, y: upperRightCornerY)) ||
            lineIntersecsLine(p1, p2, CGPoint(x: upperRightCornerX,y: upperRightCornerY), CGPoint(x: bottomRightCornerX,y: bottomRightCornerY)) ||
            lineIntersecsLine(p1, p2, CGPoint(x: bottomRightCornerX,y: bottomRightCornerY), CGPoint(x: bottomLeftCornerX,y: bottomLeftCornerY)) ||
            lineIntersecsLine(p1, p2, CGPoint(x: bottomLeftCornerX,y: bottomLeftCornerY), CGPoint(x: upperLeftCornerX,y: upperLeftCornerY)) ||
            (p1.x > upperLeftCornerX && p1.x < upperRightCornerX && p1.y < upperLeftCornerY && p1.y > bottomLeftCornerY) ||
            (p2.x > upperLeftCornerX && p2.x < upperRightCornerX && p2.y < upperLeftCornerY && p2.y > bottomLeftCornerY)
    }
    
    func lineIntersecsLine(_ l1p1: CGPoint,_ l1p2: CGPoint,_ l2p1: CGPoint,_ l2p2:CGPoint) -> Bool {
        let q = (l1p1.y - l2p1.y) * (l2p2.x - l2p1.x) - (l1p1.x - l2p1.x) * (l2p2.y - l2p1.y)
        let d = (l1p2.x - l1p1.x) * (l2p2.y - l2p1.y) - (l1p2.y - l1p1.y) * (l2p2.x - l2p1.x)
        
        if d == 0 {
            return false;
        }
        
        let r = q / d;
        
        let q2 = (l1p1.y - l2p1.y) * (l1p2.x - l1p1.x) - (l1p1.x - l2p1.x) * (l1p2.y - l1p1.y)
        
        let s = q2 / d;
        
        if r < 0 || r > 1 || s < 0 || s > 1 {
            return false
        }
        
        return true;
    }
}
