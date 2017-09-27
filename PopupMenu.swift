//
//  PopupMenu.swift
//  Orbit
//
//  Created by Scott Edwards on 09/12/2015.
//  Copyright © 2015 Scott Edwards. All rights reserved.
//

import Foundation
import SpriteKit

class PopupMenu: NSObject {
    
    var frame = SKShapeNode(rectOf: CGSize(width: 350, height: 125))
    
    init(loc: CGPoint) {
        frame.position = loc
        frame.fillColor = SKColor.lightGray
        // adding controls to the Menu
        let acceptButton = SKLabelNode(text: "Create")
        acceptButton.name = "btnCreate"
        acceptButton.fontSize = 12
        acceptButton.fontColor = SKColor.black
        frame.addChild(acceptButton)
        acceptButton.position = CGPoint(x: -70, y: -10)
    }
    
    func addToView(_ scene: GameScene) {
        scene.addChild(frame)
    }
    
    func removeFromView() {
        frame.removeFromParent()
    }
    
}
