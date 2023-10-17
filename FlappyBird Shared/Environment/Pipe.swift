//
//  Pipe.swift
//  FlappyBird
//
//  Created by Air on 16.10.2023.
//

import SpriteKit

class Pipe: SKSpriteNode {
    
    public var distanceBetweenTopLowPipe: CGFloat = 100
    
    private var node: SKSpriteNode!
    
    override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        configureLowerPipe()
        configureTopPipe()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureLowerPipe() {
        let lowerPipe = SKSpriteNode(imageNamed: "pipe-green")
        
        lowerPipe.physicsBody = configurePhysics(node: lowerPipe)
        
        addChild(lowerPipe)
    }
    
    private func configureTopPipe() {
        let topPipe = SKSpriteNode(imageNamed: "pipe-green")
        topPipe.position.y += size.height + distanceBetweenTopLowPipe
        topPipe.zRotation = .pi
        topPipe.xScale = -1
        
        topPipe.physicsBody = configurePhysics(node: topPipe)
        
        addChild(topPipe)
    }
    
    private func configurePhysics(node: SKSpriteNode) -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(texture: node.texture!, size: node.size)
        
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.isDynamic = false
        physicsBody.friction = 0
        physicsBody.restitution = 0
        physicsBody.categoryBitMask = PhysicsCollision.pipeCategory
        physicsBody.collisionBitMask = PhysicsCollision.birdCategory
        physicsBody.contactTestBitMask = PhysicsCollision.pipeCategory
        
        return physicsBody
    }
    
}
