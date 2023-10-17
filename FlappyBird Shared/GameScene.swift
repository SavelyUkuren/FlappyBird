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
    
    private var backgroundImage: SKSpriteNode!
    
    private var startMessage = SKSpriteNode(imageNamed: "message")
    
    private var gameState: GameState = .Menu
    
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
        self.physicsWorld.contactDelegate = self
        
        configurePipes()
        configureBase()
        configureBird()
        configureStartMessage()
        configureBackgroundImage()
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        base.update(currentTime)
        pipes.update(currentTime)
    }
    
    private func configureBackgroundImage() {

        backgroundImage = SKSpriteNode(imageNamed: "background")
        
        backgroundImage.setScale(1.6)
        backgroundImage.zPosition = -1
        backgroundImage.position.y = 100
        
        addChild(backgroundImage)
    }
    
    private func configurePipes() {
        pipes.position.y = -330
        pipes.position.x = 1000
        pipes.zPosition = 1
        pipes.setScale(2)
        
        addChild(pipes)
    }
    
    private func configureBase() {
        base.position.y = -350
        base.zPosition = 2
        base.setScale(2)
        base.startMove()
        
        addChild(base)
    }
    
    private func configureBird() {
        redBird.position.x = -300
        redBird.position.y = 150
        redBird.zPosition = 3
        redBird.setScale(2)
        
        addChild(redBird)
    }
    
    private func configureStartMessage() {
        startMessage.setScale(2.5)
        startMessage.zPosition = 20
        
        addChild(startMessage)
    }
    
    private func gameOver() {
        pipes.stopMove()
        base.stopMove()
        redBird.stopAnimation()
    }
    
    private func startGame() {
        startMessage.removeFromParent()
        pipes.startMove()
        redBird.startFlying()
    }
    
    private func restartGame() {
        pipes.restart()
        base.startMove()
        redBird.restart()
        
        redBird.removeFromParent()
        
        configureBird()
        configureStartMessage()
    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let result = contact.bodyA.categoryBitMask & contact.bodyB.categoryBitMask
        
        switch result {
        case PhysicsCollision.birdCategory & PhysicsCollision.baseCategory:
            gameOver()
            gameState = .GameOver
            break
        case PhysicsCollision.birdCategory & PhysicsCollision.pipeCategory:
            gameOver()
            gameState = .GameOver
            break
        default:
            break
        }
        
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
        
        if gameState == .Menu {
            startGame()
            redBird.startFlying()
            gameState = .Playing
        }
        
        if gameState == .Playing {
            redBird.jump()
        }
        
        if gameState == .GameOver {
            restartGame()
            gameState = .Menu
        }
        
    }

}
#endif

