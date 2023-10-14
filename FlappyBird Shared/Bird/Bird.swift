//
//  Bird.swift
//  FlappyBird
//
//  Created by Air on 12.10.2023.
//

import SpriteKit

class Bird: SKSpriteNode {
    
    // Physics
    public var jumpImpulse = CGVector(dx: 0, dy: 400)
    
    public var mass: CGFloat = 1
    
    public var physicsRadius: CGFloat = 14
    
    // Animation
    public var animationTextures: [SKTexture]!
    
    public var animationSpeed: CGFloat = 0.2
    
    override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        configureBird()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func configureBird() {
        zPosition = 10
        
        physicsBody = configurePhysics(circleOfRadius: physicsRadius)
        physicsBody?.density = 0
        physicsBody?.friction = 0
        physicsBody?.restitution = 0
        physicsBody?.mass = mass
        physicsBody?.affectedByGravity = false
    }
    
    public func configurePhysics(circleOfRadius: CGFloat) -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(circleOfRadius: circleOfRadius)
        physicsBody.allowsRotation = false
        return physicsBody
    }
    
    public func jump() {
        physicsBody?.velocity = .zero
        physicsBody?.applyImpulse(jumpImpulse)
    }
    
    public func flyAction() -> SKAction {
        let action = SKAction.repeatForever(SKAction.animate(with: animationTextures, timePerFrame: animationSpeed))
        return action
    }
    
    public func startFlying() {
        physicsBody?.affectedByGravity = true
    }
    
    public func stopFlying() {
        physicsBody?.affectedByGravity = false
    }
    
}
