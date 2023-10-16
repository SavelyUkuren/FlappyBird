//
//  GameScene.swift
//  FlappyBird Shared
//
//  Created by Air on 12.10.2023.
//

import SpriteKit

class GameScene: SKScene {
    
    private var redBird = RedBird(texture: nil, color: .red, size: CGSize(width: 34, height: 24))
    
    private var base = Base(texture: nil, color: .red, size: CGSize(width: 336, height: 112))
    
    private var pipes = Pipes(texture: nil, color: .clear, size: CGSize(width: 52, height: 320))
    
    private var startMessage = SKSpriteNode(imageNamed: "message")
    
    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    func setUpScene() {
        pipes.position.y = -330
        pipes.position.x = 500
        pipes.startMove()
        
        base.position.y = -350
        base.startMove()
        
        
        
        redBird.position.y = 150
        
        startMessage.setScale(2.5)
        
        //addChild(startMessage)
        addChild(redBird)
        addChild(base)
        addChild(pipes)
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        base.update(currentTime)
        pipes.update(currentTime)
    }
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
   
}
#endif

#if os(OSX)
// Mouse-based event handling
extension GameScene {

    override func mouseDown(with event: NSEvent) {
        
    }
    
    override func mouseDragged(with event: NSEvent) {
        
    }
    
    override func mouseUp(with event: NSEvent) {
        
    }
    
    override func keyDown(with event: NSEvent) {
        startMessage.removeFromParent()
        redBird.startFlying()
        redBird.jump()
    }

}
#endif

