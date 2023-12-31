//
//  Bird.swift
//  FlappyBird
//
//  Created by Air on 12.10.2023.
//

import SpriteKit

class Bird: SKSpriteNode {
    
    // Physics
    public var jumpImpulse = CGVector(dx: 0, dy: 500)
    
    public var mass: CGFloat = 1
    
    public var physicsRadius: CGFloat = 13
    
    public var rotateDownSpeed: CGFloat = 6
    
    // Animation
    public var animationTextures: [SKTexture]!
    
    public var animationSpeed: CGFloat = 0.2
    
#if os(OSX)
    override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        configureBird()
    }
#endif
    
#if os(iOS)
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        configureBird()
    }
#endif
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func configureBird() {
        physicsBody = configurePhysics(circleOfRadius: physicsRadius)
        physicsBody?.density = 0
        physicsBody?.friction = 0
        physicsBody?.restitution = 0
        physicsBody?.mass = mass
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCollision.birdCategory
        physicsBody?.collisionBitMask = PhysicsCollision.baseCategory | PhysicsCollision.pipeCategory
        physicsBody?.contactTestBitMask = PhysicsCollision.birdCategory
    }
    
    public func configurePhysics(circleOfRadius: CGFloat) -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(circleOfRadius: circleOfRadius)
        physicsBody.allowsRotation = false
        return physicsBody
    }
    
    public func jump() {
        physicsBody?.velocity = .zero
        physicsBody?.applyImpulse(jumpImpulse)
        zRotation = .pi / 4
    }
    
    public func flyAction() -> SKAction {
        let action = SKAction.repeatForever(SKAction.animate(with: animationTextures, timePerFrame: animationSpeed))
        return action
    }
    
    public func startFlying() {
        physicsBody?.affectedByGravity = true
    }
    
    public func restart() {
        physicsBody?.affectedByGravity = false
        run(flyAction(), withKey: "flyAnimation")
        zRotation = 0
        physicsBody?.velocity = .zero
    }
    
    public func stopAnimation() {
        removeAction(forKey: "flyAnimation")
    }
    
    public func update(_ currentTime: TimeInterval) {
        if physicsBody!.velocity.dy < 0 {
            
            let currentDegree = (zRotation * 180 / .pi)
            
            if currentDegree > -90 {
                zRotation -= rotateDownSpeed * .pi / 180
            }
            
        }
    }
    
}
