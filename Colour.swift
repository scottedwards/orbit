//
//  Colour.swift
//  Orbit
//
//  Created by Scott Edwards on 05/11/2015.
//  Copyright © 2015 Scott Edwards. All rights reserved.
//

import Foundation
import SpriteKit

class Colour {
    static func getFromRGB(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> NSColor {
        return NSColor(calibratedRed: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}


