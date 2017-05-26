//
//  PathFollowingSteering.swift
//  IOS - TP2
//
//  Created by Agustin Mounier on 5/25/17.
//  Copyright © 2017 Agustin Mounier. All rights reserved.
//

import UIKit

class PathFollowingSteering: NSObject, SteeringProtocol {

    var path = [CGPoint]()

    func steer() -> CGPoint {
        if !path.isEmpty {
            return path.remove(at: 0)
        }
        return CGPoint()
    }
    
    func steeringEnded() -> Bool {
        return path.isEmpty
    }
    
    func setPath(path: [CGPoint]) {
        self.path = path
    }
}
