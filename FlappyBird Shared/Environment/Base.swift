//
//  Base.swift
//  FlappyBird
//
//  Created by Air on 14.10.2023.
//

import SpriteKit

class Base: SKSpriteNode {
    
    public var velocity: CGFloat = 100
    
    private var grounds: [SKSpriteNode] = []
    
    override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        // TODO: Make scaleble
        //setScale(2)
        createGrounds()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func startMove() {
        grounds.forEach { base in
            let moveAction = SKAction.move(by: CGVector(dx: -velocity, dy: 0), duration: 1)
            base.run(SKAction.repeatForever(moveAction))
        }
    }
    
    public func stopMove() {
        grounds.forEach { $0.removeAction(forKey: "move") }
    }
    
    public func update(_ currentTime: TimeInterval) {
        resetBase()
    }
    
    private func createGrounds() {
        for i in -1..<3 {
            let s = SKSpriteNode(imageNamed: "base")
            s.zPosition = 5
            s.position.x = size.width * CGFloat(i)
            
            s.physicsBody = SKPhysicsBody(rectangleOf: size)
            s.physicsBody?.affectedByGravity = false
            s.physicsBody?.friction = 0
            s.physicsBody?.restitution = 0
            s.physicsBody?.allowsRotation = false
            s.physicsBody?.isDynamic = false
            
            grounds.append(s)
            addChild(s)
        }
    }
    
    private func resetBase() {
        // If the first base out of screen, then the first base moves to last base position
        if grounds[0].position.x <= -self.size.width * 2 {
            grounds[0].position.x = grounds.last!.position.x + self.size.width
            
            let firstBase = grounds.removeFirst()
            grounds.append(firstBase)
        }
            
    }
    
}
