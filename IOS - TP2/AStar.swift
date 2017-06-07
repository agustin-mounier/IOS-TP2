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
    
    var gameMap: SKTileMapNode!
    var players: [Player]!
    var openSet = Set<CGPoint>()
    var closedSet = Set<CGPoint>()
    var cameFrom = [CGPoint: CGPoint]()
    var gScore = [CGPoint: CGFloat]()
    var fScore = [CGPoint: CGFloat]()
    
    init(map: SKTileMapNode) {
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
}
