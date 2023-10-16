//
//  Pipes.swift
//  FlappyBird
//
//  Created by Air on 16.10.2023.
//

import SpriteKit

class Pipes: SKSpriteNode {
    
    public var randomHeight: ClosedRange<CGFloat> = -120...120
    
    public var distance: CGFloat = 250
    
    public var velocity: CGFloat = 100
    
    private var pipeArray: [Pipe] = []
    
    override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        configurePipes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func startMove() {
        pipeArray.forEach { pipe in
            let moveAction = SKAction.move(by: CGVector(dx: -velocity, dy: 0), duration: 1)
            pipe.run(SKAction.repeatForever(moveAction), withKey: "move")
        }
    }
    
    public func stopMove() {
        pipeArray.forEach { $0.removeAction(forKey: "move") }
    }
    
    public func update(_ currentTime: TimeInterval) {
        resetPipes()
    }
    
    private func configurePipes() {
        for i in 0..<3 {
            let pipe = Pipe(texture: texture, color: color, size: size)
            pipe.position.x = CGFloat(i) * distance + position.x
            pipe.position.y = CGFloat.random(in: randomHeight)
            
            pipeArray.append(pipe)
            
            addChild(pipe)
        }
    }
    
    private func resetPipes() {
        if pipeArray[0].position.x <= -self.size.width * 2 - distance - position.x {
            
            pipeArray[0].position.x = pipeArray.last!.position.x + distance
            pipeArray[0].position.y = CGFloat.random(in: randomHeight)
            
            let firstPipe = pipeArray.removeFirst()
            pipeArray.append(firstPipe)
            
        }
    }
    
}
