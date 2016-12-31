//
//  GameScene.swift
//  du=iv
//
//  Created by luis castillo on 8/1/16.
//  Copyright (c) 2016 luis castillo. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let player = SKSpriteNode(imageNamed: "circle-1")
    let player2 = SKSpriteNode(imageNamed: "circle-1")
    var scoreLabel : SKLabelNode!
    var initialPlayerPosiiton: CGPoint!
    var obstacle : SKSpriteNode!
    var scoreNode : SKSpriteNode!
    var score = 0
    var players : SKSpriteNode!
    

    override func didMove(to view: SKView) {
        /* Setup your scene here */
        self.physicsWorld.gravity = CGVector(dx: 0,dy: 0)
        physicsWorld.contactDelegate = self
        addPlayer()
        scoreLabel = childNode(withName: "score") as! SKLabelNode
        
        players = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 670, height: 10))
        players.position = CGPoint(x: self.size.width / 2, y: 360)
        players.name = "players"
        players.physicsBody?.isDynamic = false
        players.physicsBody = SKPhysicsBody(rectangleOf: players.size)
        players.physicsBody?.categoryBitMask = CollisionBitmask.Player
        players.physicsBody?.collisionBitMask = 0
        players.physicsBody?.contactTestBitMask = CollisionBitmask.Obstacle
        addChild(players)
        //view.showsPhysics = true
       
            }
    
    
    
    func addRandomRow () {
        let randomNumber = Int(arc4random_uniform(6))
        
        addRow(RowType(rawValue: randomNumber)!)
    }
    
    var lastUpdateTimeInterval = TimeInterval()
    var lastYieldTimeInterval = TimeInterval()
    
    func updateWithTimeSinceLastUpdate(_ timeSinceLastUpdate: CFTimeInterval) {
        lastYieldTimeInterval += timeSinceLastUpdate
        if score < 10 && lastYieldTimeInterval > 1.3 {
            lastYieldTimeInterval = 0
            addRandomRow()
        }
        if lastYieldTimeInterval > 0.71 && score > 10{
            lastYieldTimeInterval = 0
            addRandomRow()
        }
        
        
 
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let maximumPossibleForce = touch.maximumPossibleForce
            if maximumPossibleForce > 0 {
                // 3d touch
                let force = touch.force
                let normalizedForce = force/maximumPossibleForce
                
                player2.position.x = (self.size.width / 2) - normalizedForce * (self.size.width/2 - 25)
                player.position.x = (self.size.width / 2) + normalizedForce * (self.size.width/2 - 25)
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetPlayerPosition()
    }
    
    func resetPlayerPosition() {
        player.removeAllActions()
        player.run(SKAction.move(to: initialPlayerPosiiton, duration: 0.53))
        player2.removeAllActions()
        player2.run(SKAction.move(to: initialPlayerPosiiton, duration: 0.53))
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        if let touch = touches.first {
            let maximumPossibleForce = touch.maximumPossibleForce
            if maximumPossibleForce > 0 {
                // 3d touch
                let force = touch.force
                let normalizedForce = force/maximumPossibleForce
                
                player2.position.x = (self.size.width / 2) - normalizedForce * (self.size.width/2 - 25)
                player.position.x = (self.size.width / 2) + normalizedForce * (self.size.width/2 - 25)
            }
            else {
                // no 3d touch
                
                player.removeAllActions()
                player.run(SKAction.move(to: CGPoint(x: self.size.width/2 + 430, y: initialPlayerPosiiton.y), duration: 0.6))
                player2.removeAllActions()
                player2.run(SKAction.move(to: CGPoint(x: self.size.width/2 - 430, y: initialPlayerPosiiton.y), duration: 0.6))
            }
        }
        
        
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        let timeSinceLastUpdate = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        updateWithTimeSinceLastUpdate(timeSinceLastUpdate)
        
    }
    
    func showGameOver() {
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameOverScene = GameOverScene(size:self.size)
        self.view?.presentScene(gameOverScene,transition:transition)
        
    }

    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.node!.name == "player" || contact.bodyB.node!.name == "player" {
            showGameOver()
            
            }
        
        if contact.bodyA.node!.name == "players" || contact.bodyB.node!.name == "players"{
            
            /* Increment points */
            score += 1
            
            let defaults = UserDefaults.standard
            defaults.set(score, forKey: "scoreKey")
            
            defaults.synchronize()
            
            /* Update score label */
            scoreLabel.text = String(score)
            
            /* We can return now */
            return
        }
        
    }
}







