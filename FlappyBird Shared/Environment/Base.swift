//
//  Base.swift
//  FlappyBird
//
//  Created by Air on 14.10.2023.
//

import SpriteKit

class Base: SKSpriteNode {
    
    public var velocity: CGFloat = 100
    
    // Value at which the base remove
    public var leftScreenEdge: CGFloat = -1000
    
    private var grounds: [SKSpriteNode] = []
    
    private var baseCount = 6
    
    override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        createGrounds()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func startMove() {
        grounds.forEach { base in
            let moveAction = SKAction.move(by: CGVector(dx: -velocity, dy: 0), duration: 1)
            base.run(SKAction.repeatForever(moveAction), withKey: "move")
        }
    }
    
    public func stopMove() {
        grounds.forEach { $0.removeAction(forKey: "move") }
    }
    
    public func update(_ currentTime: TimeInterval) {
        resetBase()
    }
    
    private func createGrounds() {
        for i in -(baseCount / 2)..<baseCount {
            let s = SKSpriteNode(imageNamed: "base")
            s.zPosition = 5
            s.position.x = size.width * CGFloat(i)
            
            s.physicsBody = SKPhysicsBody(rectangleOf: size)
            s.physicsBody?.affectedByGravity = false
            s.physicsBody?.friction = 0
            s.physicsBody?.restitution = 0
            s.physicsBody?.allowsRotation = false
            s.physicsBody?.isDynamic = false
            s.physicsBody?.categoryBitMask = PhysicsCollision.baseCategory
            
            grounds.append(s)
            addChild(s)
        }
    }
    
    private func resetBase() {
        // If the first base out of screen, then the first base moves to last base position
        if grounds[0].position.x <= leftScreenEdge {
            grounds[0].position.x = grounds.last!.position.x + (self.size.width / xScale)
            
            let firstBase = grounds.removeFirst()
            grounds.append(firstBase)
        }
            
    }
    
}
