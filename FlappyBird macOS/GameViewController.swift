//
//  GameViewController.swift
//  FlappyBird macOS
//
//  Created by Air on 12.10.2023.
//

import Cocoa
import SpriteKit
import GameplayKit

class GameViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene.newGameScene()
        
        // Present the scene
        let skView = self.view as! SKView
        skView.frame = NSRect(x: 0, y: 0, width: 1920, height: 1080)
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        //skView.showsPhysics = true
    }

}

