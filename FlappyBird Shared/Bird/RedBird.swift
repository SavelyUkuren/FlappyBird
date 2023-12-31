//
//  RedBird.swift
//  FlappyBird
//
//  Created by Air on 12.10.2023.
//

import SpriteKit

class RedBird: Bird {
    
#if os(OSX)
    override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        animationTextures = configureAnimationTextures()
        
        run(flyAction(), withKey: "flyAnimation")
    }
#endif

    
#if os(iOS)
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        animationTextures = configureAnimationTextures()
        
        run(flyAction(), withKey: "flyAnimation")
    }
#endif
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureAnimationTextures() -> [SKTexture] {
        var arr: [SKTexture] = []
        
        arr.append(SKTexture(imageNamed: "redbird-downflap"))
        arr.append(SKTexture(imageNamed: "redbird-midflap"))
        arr.append(SKTexture(imageNamed: "redbird-upflap"))
        arr.append(SKTexture(imageNamed: "redbird-midflap"))
        
        arr.forEach { texture in
            texture.filteringMode = .nearest
        }
        
        return arr
    }
    
}
