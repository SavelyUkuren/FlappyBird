//
//  Pipe.swift
//  FlappyBird
//
//  Created by Air on 16.10.2023.
//

import SpriteKit

class Pipe: SKSpriteNode {
    
    public var distanceBetweenTopLowPipe: CGFloat = 100
    
    private var triggerNode: SKSpriteNode!
    
    override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        configureLowerPipe()
        configureTopPipe()
        configureTrigger()
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
    
    private func configureTrigger() {
        triggerNode = SKSpriteNode(color: .red, size: CGSize(width: 10, height: distanceBetweenTopLowPipe))
        triggerNode.position.y = 210
        triggerNode.position.x = 10
        triggerNode.alpha = 0.5
        
        triggerNode.physicsBody = SKPhysicsBody(rectangleOf: triggerNode.size)
        triggerNode.physicsBody?.affectedByGravity = false
        triggerNode.physicsBody?.isDynamic = false
        triggerNode.physicsBody?.categoryBitMask = PhysicsCollision.triggerCategory
        triggerNode.physicsBody?.contactTestBitMask = PhysicsCollision.birdCategory
        
        addChild(triggerNode)
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
