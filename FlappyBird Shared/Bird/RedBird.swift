//
//  RedBird.swift
//  FlappyBird
//
//  Created by Air on 12.10.2023.
//

import SpriteKit

class RedBird: Bird {
    
    override init() {
        super.init()
        
        currentTexture = SKTexture(imageNamed: "redbird-midflap")
        node.texture = currentTexture
        
        animationTextures = configureAnimationTextures()
        
        node.run(flyAction())
        node.xScale = 2
        node.yScale = 2
    }
    
    private func configureAnimationTextures() -> [SKTexture] {
        var arr: [SKTexture] = []
        
        arr.append(SKTexture(imageNamed: "redbird-downflap"))
        arr.append(SKTexture(imageNamed: "redbird-midflap"))
        arr.append(SKTexture(imageNamed: "redbird-upflap"))
        arr.append(SKTexture(imageNamed: "redbird-midflap"))
        
        return arr
    }
    
}
