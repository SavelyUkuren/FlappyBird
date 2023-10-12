//
//  Bird.swift
//  FlappyBird
//
//  Created by Air on 12.10.2023.
//

import SpriteKit

class Bird {
    
    public var jumpImpulse = CGVector(dx: 0, dy: 400)
    
    public var mass: CGFloat = 1
    
    public var physicsRadius: CGFloat = 14
    
    private(set) var node: SKSpriteNode!
    
    init() {
        
        configureBird()
        
    }
    
    public func configureBird() {
        node = SKSpriteNode(imageNamed: "redbird-midflap")
        node.physicsBody = configurePhysics(circleOfRadius: physicsRadius)
        node.physicsBody?.density = 0
        node.physicsBody?.friction = 0
        node.physicsBody?.restitution = 0
        node.physicsBody?.mass = mass
    }
    
    public func configurePhysics(circleOfRadius: CGFloat) -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(circleOfRadius: circleOfRadius)
        physicsBody.allowsRotation = false
        return physicsBody
    }
    
    public func jump() {
        node.physicsBody?.velocity = .zero
        node.physicsBody?.applyImpulse(jumpImpulse)
    }
    
}
