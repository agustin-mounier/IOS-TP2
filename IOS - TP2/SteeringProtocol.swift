//
//  SteeringProtocol.swift
//  IOS - TP2
//
//  Created by Agustin Mounier on 5/25/17.
//  Copyright © 2017 Agustin Mounier. All rights reserved.
//

import UIKit

protocol SteeringProtocol {
    func steer() -> CGPoint
    
    func steeringEnded() -> Bool
}
