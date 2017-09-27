//
//  AppDelegate.swift
//  Orbit
//
//  Created by Scott Edwards on 05/11/2015.
//  Copyright (c) 2015 Scott Edwards. All rights reserved.
//


import Cocoa
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!
    
    var scene: GameScene!
    
    @IBOutlet weak var staticMenuOption: NSMenuItem!
    @IBOutlet weak var orbitMenuItem: NSMenuItem!
    
    @IBAction func staticOptionSelected(_ sender: NSMenuItem) {
        if sender.state == 0 {
            sender.state = 1
            orbitMenuItem.state = 0
            scene.toggleLaunchOption()
        }
    }
    
    @IBAction func orbitOptionSelected(_ sender: NSMenuItem) {
        if sender.state == 0 {
            sender.state = 1
            staticMenuOption.state = 0
            scene.toggleLaunchOption()
        }
    }
    
    @IBAction func clearPlanets(_ sender: AnyObject) {
        scene.clearPlanets()
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        /* Pick a size for the scene */
        scene = GameScene(fileNamed: "GameScene")
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .aspectFill
        scene.size = skView.bounds.size
        self.skView!.presentScene(scene)
            
        Collisions.reDrawBounds(scene)
            
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        self.skView!.showsFPS = true
        self.skView!.showsNodeCount = true
        
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
