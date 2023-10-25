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
    
    private var gameOverMessage = SKSpriteNode(imageNamed: "gameover")
    
    private var scoreLabel: SKLabelNode = SKLabelNode(fontNamed: "Flappy Bird")
    
    private var score = 0
    
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
        configureGameOverMessage()
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        base.update(currentTime)
        pipes.update(currentTime)
        redBird.update(currentTime)
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
        #if os(OSX)
        base.position.y = -350
        #endif
        
        #if os(iOS)
        base.position.y = -400
        #endif
        
        base.zPosition = 2
        base.setScale(2)
        base.startMove()
        
        addChild(base)
    }
    
    private func configureBird() {
        #if os(OSX)
        redBird.position.x = -300
        #endif
        
        #if os(iOS)
        redBird.position.x = -150
        #endif
        
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
    
    private func configureScoreLabel() {
        scoreLabel.text = "0"
        scoreLabel.position.y = 250
        scoreLabel.zPosition = 5
        scoreLabel.fontSize = 120
        
        addChild(scoreLabel)
    }
    
    private func configureGameOverMessage() {
        gameOverMessage.setScale(2.5)
        gameOverMessage.zPosition = 10
        gameOverMessage.alpha = 0
        
        addChild(gameOverMessage)
    }
    
    private func gameOver() {
        gameOverMessage.alpha = 1
        pipes.stopMove()
        base.stopMove()
        redBird.stopAnimation()
    }
    
    private func startGame() {
        configureScoreLabel()
        startMessage.removeFromParent()
        pipes.startMove()
        redBird.startFlying()
    }
    
    private func restartGame() {
        score = 0
        updateScoreLabel()
        
        gameOverMessage.alpha = 0
        
        pipes.restart()
        base.startMove()
        redBird.restart()
        
        redBird.removeFromParent()
        scoreLabel.removeFromParent()
        
        configureBird()
        configureStartMessage()
    }
    
    private func updateScoreLabel() {
        scoreLabel.text = "\(score)"
    }
    
    private func tapOnScreen() {
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
        case PhysicsCollision.birdCategory & PhysicsCollision.triggerCategory:
            score += 1
            updateScoreLabel()
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
        tapOnScreen()
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
        
        tapOnScreen()
        
    }

}
#endif

