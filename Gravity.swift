//
//  Gravity.swift
//  Orbit
//
//  Created by Scott Edwards on 08/11/2015.
//  Copyright © 2015 Scott Edwards. All rights reserved.
//

import Foundation
import SpriteKit

class Gravity {
    
    
    static func applyGravitationalForce(_ gravPoint: Planet, planet: Planet) {
        let force: Double = findForce(gravPoint, planet: planet)
        let acc: Double = -force / planet.getMass()
        let angle = getAngle(planet, gravPoint: gravPoint)
        let accComponents = CGVector(dx: (acc * cos(angle)), dy: (acc * sin(angle)))
        planet.adjustVelocity(accComponents)
    }
    
    static func findForce(_ gravPoint: Planet, planet: Planet) -> Double {
        let distanceX = Double(gravPoint.getPosition().x - planet.getPosition().x)
        let distanceY = Double(gravPoint.getPosition().y - planet.getPosition().y)
        var distance: Double = sqrt((distanceX * distanceX) + (distanceY * distanceY))
        //the following is to stop the object being catapulted away infinetly fast
        //(which happens when the distance approaches 0
        if (distance < 40) {
            distance = 40
        }
        return (gravPoint.getMass() * planet.getMass()) / ((distance * distance)) * 0.2
    }
    
    static func getAngle(_ planet: Planet, gravPoint: Planet) -> Double {
        let dy = Double(planet.getPosition().y - gravPoint.getPosition().y)
        let dx = Double(planet.getPosition().x - gravPoint.getPosition().x)
        var theta: Double = atan(dy/dx)
        
        if (dy < 0 && dx < 0) {
            theta = .pi + theta
        } else if (dy > 0 && dx < 0) {
            theta = .pi + theta
        } else if (dy < 0 && dx > 0) {
            theta = (2 * .pi) + theta
        }        

        return theta
    }
}
