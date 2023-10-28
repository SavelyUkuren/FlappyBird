//
//  SoundController.swift
//  FlappyBird
//
//  Created by Air on 28.10.2023.
//

import SpriteKit

class SoundController: SKNode {
    
    enum Sound {
        case Die, Hit, Point, Swoosh, Jump
    }
    
    private var dieSoundAction = SKAction.playSoundFileNamed("die.mp3", waitForCompletion: false)
    
    private var hitSoundAction = SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false)
    
    private var pointSoundAction = SKAction.playSoundFileNamed("point.mp3", waitForCompletion: false)
    
    private var swooshSoundAction = SKAction.playSoundFileNamed("swoosh.mp3", waitForCompletion: false)
    
    private var jumpSoundAction = SKAction.playSoundFileNamed("wing.mp3", waitForCompletion: false)
    
    public func play(sound: Sound) {
        switch sound {
        case .Die:
            run(dieSoundAction)
        case .Hit:
            run(hitSoundAction)
        case .Point:
            run(pointSoundAction)
        case .Swoosh:
            run(swooshSoundAction)
        case .Jump:
            run(jumpSoundAction)
        }
    }
    
    
}
