//
//  Pipes.swift
//  FlappyBird
//
//  Created by Air on 16.10.2023.
//

import SpriteKit

class Pipes: SKSpriteNode {
    
    public var randomHeight: ClosedRange<CGFloat> = -70...30
    
    public var distance: CGFloat = 170
    
    public var velocity: CGFloat = 100
    
    // Value at which the base remove
    public var leftScreenEdge: CGFloat = -1000
    
    private var pipeArray: [Pipe] = []
    
    private var pipesCount = 10
    
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
        for i in 0..<pipesCount {
            let pipe = Pipe(texture: texture, color: color, size: size)
            pipe.position.x = CGFloat(i) * distance + position.x
            pipe.position.y = CGFloat.random(in: randomHeight)
            
            pipeArray.append(pipe)
            
            addChild(pipe)
        }
    }
    
    private func resetPipes() {
        if pipeArray[0].position.x <= leftScreenEdge {
            
            pipeArray[0].position.x = pipeArray.last!.position.x + distance
            pipeArray[0].position.y = CGFloat.random(in: randomHeight)
            
            let firstPipe = pipeArray.removeFirst()
            pipeArray.append(firstPipe)
            
        }
    }
    
}
