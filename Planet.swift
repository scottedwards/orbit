//
//  Objects.swift
//  Orbit
//
//  Created by Scott Edwards on 05/11/2015.
//  Copyright © 2015 Scott Edwards. All rights reserved.
//

import Cocoa
import SpriteKit

class Planet: NSObject {
    
    fileprivate let mass: Double
    fileprivate let name: String
    fileprivate var velocity: CGVector
    var sprite: SKSpriteNode
    
    
    init(name: String, mass: Double, velocity: CGVector, scene: GameScene) {
        self.name = name
        self.mass = mass
        self.velocity = velocity
        self.sprite = SKSpriteNode(imageNamed: name)
        scene.addChild(self.sprite)
    }
    
    func getMass() -> Double {
        return self.mass
    }

    func getPosition() -> CGPoint {
        return self.sprite.position
    }
    
    
    func getVelocity() -> CGVector {
        return self.velocity
    }
    
    func adjustVelocity(_ acceleration: CGVector) {
        
        if self.name != "Sun" {
            //check to see if the either x or y is  about to change direction
            //this is done by checking to see if either x or y component for acceleration is greater than the veloocity component
            //if this happens it means the planet is very close to it maximum (either side)
            //if then both components of acceleration are in the same direction of velocity we can declare the planet to have changed direction
            if modulus(self.getVelocity().dx) - modulus(acceleration.dx) < 0 || modulus(self.getVelocity().dy) - modulus(acceleration.dy) < 0 {
                if sameSign(self.getVelocity().dx, y: acceleration.dx) && sameSign(self.getVelocity().dy, y: acceleration.dy) {
                    if self.sprite.zPosition < 10 {
                        self.sprite.zPosition += 10
                    } else {
                        self.sprite.zPosition -= 10
                    }
                }
            }
        }
        
        self.velocity.dx += acceleration.dx
        self.velocity.dy += acceleration.dy
    }
    
    func setVelocity(_ velocity: CGVector) {
        self.velocity = velocity
    }
    
    func setPosition(_ loc: CGPoint) {
        self.sprite.position = loc
    }
    
    func scale(_ factor: CGFloat) {
        self.sprite.setScale(factor)
    }
    
    func runAction(_ action: SKAction) {
        self.sprite.run(action)
    }
    
    func remove() {
        self.sprite.removeFromParent()
    }
    
    func getName() -> String {
        return self.name
    }
    
    func sameSign(_ x: CGFloat, y: CGFloat) -> Bool {
        return ((x < 0) == (y < 0))
    }
    
    func modulus(_ x: CGFloat) -> CGFloat {
        if x < 0 {
            return -x
        } else {
            return x
        }
    }
    
}
