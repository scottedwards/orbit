//
//  Collisions.swift
//  Orbit
//
//  Created by Scott Edwards on 06/11/2015.
//  Copyright © 2015 Scott Edwards. All rights reserved.
//

//COOMMENT FOR doing collions (interplanetary) THING:
// PREDICT WHERE PLABET WILL BE AFTER APPLYING FORCE BY USING VELOCITY AND IF IT WILL BE COLLIDING PREPROCESS THE COLLISION AND MOVE ACCORDINGLY

//for bouncy thing, just make it so it does nothing when intersecting with a side wall but going in the direction of the centre of the screen

import Foundation
import SpriteKit

class Collisions {
    
    static var edges: [SKShapeNode]!
    static var recentlyCollided = false
    static var n: Int = 0
    
    static func isCollidingWithEdge(_ object: Planet, scene: GameScene) {
        for edge in edges {
            if (object.sprite.intersects(edge)) {
                if (!recentlyCollided) {
                    if ((edges.index(of: edge)!) % 2 == 0) {
                        //flip the horzontal component
                        object.setVelocity(CGVector(dx: -(object.getVelocity().dx), dy: object.getVelocity().dy))
                        recentlyCollided = true
                    } else {
                        //flip the vertical
                        object.setVelocity(CGVector(dx: object.getVelocity().dx, dy: -(object.getVelocity().dy)))
                        recentlyCollided = true
                    }
                } else {
                    n += 1
                    if (n > 4) {
                        n = 0
                        recentlyCollided = false
                    }
                }
                
            }
        }
    }
    
    static func reDrawBounds(_ scene: GameScene) {
        edges =
            [
                //left vertical
                SKShapeNode(rect: CGRect(x: 0, y: 0, width: 0, height: scene.frame.height)),
                //bottom horizontal
                SKShapeNode(rect: CGRect(x: 0, y: 0, width: scene.frame.width, height: 0)),
                //right vertical
                SKShapeNode(rect: CGRect(x: scene.frame.width, y: 0, width: 0, height: scene.frame.height)),
                //top horizontal
                SKShapeNode(rect: CGRect(x: 0, y: scene.frame.height, width: scene.frame.width, height: 0))
            ]
    }
}
