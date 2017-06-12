//
//  SKTileDefinitionExtension.swift
//  IOS - TP2
//
//  Created by Agustin Mounier on 6/9/17.
//  Copyright © 2017 Agustin Mounier. All rights reserved.
//

import UIKit
import SpriteKit

extension SKTileDefinition {
    
    func setRowAndCol(row: Int, col: Int) {
        
        if userData == nil {
            userData = NSMutableDictionary()
        }
        
        userData?.setValue(row, forKey: "row")
        userData?.setValue(col, forKey: "col")
    }
    
    func getCol() -> Int {
        return userData?.value(forKey: "col") as! Int
    }
    
    func getRow() -> Int {
        return userData?.value(forKey: "row") as! Int
    }

}
