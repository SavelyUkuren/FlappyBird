//
//  Pipe.swift
//  FlappyBird
//
//  Created by Air on 16.10.2023.
//

import SpriteKit

class Pipe: SKSpriteNode {
    
    public var distanceBetweenTopLowPipe: CGFloat = 150
    
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
        
        addChild(lowerPipe)
    }
    
    private func configureTopPipe() {
        let topPipe = SKSpriteNode(imageNamed: "pipe-green")
        topPipe.position.y += size.height + distanceBetweenTopLowPipe
        topPipe.zRotation = .pi
        topPipe.xScale = -1
        
        
        addChild(topPipe)
    }
    
}
