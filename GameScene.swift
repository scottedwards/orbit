//
//  GameScene.swift
//  Orbit
//
//  Created by Scott Edwards on 05/11/2015.
//  Copyright (c) 2015 Scott Edwards. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var rect: SKShapeNode!
    var solarSystem: SolarSystem!
    let sunMass: Double = 512
    
    var launchInOrbit: Bool = false
    
    var isMenuActive: Bool = false
    
    var planets = [
        ["Mercury", 1.0],
        ["Venus", 2.0],
        ["Earth", 2.5],
        ["Mars", 1.9],
        ["Jupiter", 4.0],
        ["Saturn", 3.5],
        ["Neptune", 3.0],
        ["Uranus", 2.9],
        ["Pluto", 0.6]
    ]
    
    var numberOfPlanets = 0
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        scene?.backgroundColor = Colour.getFromRGB(10, green: 20, blue: 40)
        addSun()
    }
    
    override func mouseDown(with theEvent: NSEvent) {
       
        let location = theEvent.location(in: self)
        
        if (numberOfPlanets < 9) {
            //add new planet
            let planetName = planets[numberOfPlanets][0] as! String
            let planetMass = planets[numberOfPlanets][1] as! Double
            
            let newPlanet = Planet(name: planetName, mass: planetMass, velocity: CGVector(dx: 0, dy: 0), scene: self)
            
            newPlanet.setPosition(location)
            newPlanet.scale(0.2)
            solarSystem.add(newPlanet)
            newPlanet.sprite.zPosition = CGFloat(numberOfPlanets)
            numberOfPlanets += 1
            
            if launchInOrbit {
                let sunMass = solarSystem.getSun().getMass()
                
                let dx = location.x - solarSystem.getSun().getPosition().x
                let dy = location.y - solarSystem.getSun().getPosition().y
                
                let radius = sqrt((dx * dx) + (dy * dy))
                //get the velocity needed to kick the planet into orbit
                let orbitalVelocity = sqrt(0.1 * sunMass / Double(radius))
                let angle = (2 * .pi) - Gravity.getAngle(newPlanet, gravPoint: solarSystem.getSun())
                
                let accComponents = CGVector(dx: orbitalVelocity * sin(angle), dy: orbitalVelocity * cos(angle))

                newPlanet.setVelocity(accComponents)
            }
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        //frames are updated at 60 hz
        
        for planet in solarSystem.getPlanets() {
            for otherPlanet in solarSystem.getPlanets() {
                if planet != otherPlanet {
                    Gravity.applyGravitationalForce(otherPlanet, planet: planet)
                }
            }
            
            Collisions.isCollidingWithEdge(planet, scene: self)
            planet.runAction(SKAction.move(by: planet.getVelocity(), duration: 1/60))
        }
    }
    
    //clear all planets from the scene and redraw the sun
    func clearPlanets() {
        for planet in solarSystem.getPlanets() {
            planet.remove()
            solarSystem.remove(planet)
        }
        addSun()
        numberOfPlanets = 0
    }
    
    //draw the sun
    func addSun() {
        let newPlanet = Planet(name: "Sun", mass: sunMass, velocity: CGVector(dx: 0, dy: 0), scene: self)
        newPlanet.setPosition(CGPoint(x: self.frame.midX, y: self.frame.midY))
        newPlanet.scale(0.6)
        newPlanet.sprite.zPosition = 10
        solarSystem = SolarSystem(sun: newPlanet)
        solarSystem.add(newPlanet)
    }
    
    func toggleLaunchOption() {
        launchInOrbit = (launchInOrbit ? false : true)
    }
}
