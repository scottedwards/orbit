//
//  SolarSystem.swift
//  Orbit
//
//  Created by Scott Edwards on 11/11/2015.
//  Copyright © 2015 Scott Edwards. All rights reserved.
//

import Cocoa

class SolarSystem: NSObject {
    
    fileprivate var planets: [Planet]
    fileprivate var sun: Planet
    
    init(sun: Planet) {
        self.planets = [Planet]()
        self.sun = sun
    }
    
    func add(_ planet: Planet) {
        self.planets.append(planet)
    }
    
    func remove(_ planet: Planet) {
        if let index = planets.index(of: planet) {
            planets.remove(at: index)
        }
    }

    func getPlanets() -> [Planet] {
        return self.planets
    }
    
    func setSun(_ sun: Planet) {
        self.sun = sun
    }
    
    func getSun() -> Planet {
        return self.sun
    }
}
