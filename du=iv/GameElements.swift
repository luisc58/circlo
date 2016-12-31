//
//  GameElements.swift
//  du=iv
//
//  Created by luis castillo on 8/1/16.
//  Copyright © 2016 luis castillo. All rights reserved.
//

import SpriteKit
import UIKit

struct CollisionBitmask {
    static let Player: UInt32 = 0x00
    static let Obstacle: UInt32 = 0x01
}

enum ObstacleType: Int {
    case small = 0
    case medium = 1
    case large = 2
}

enum RowType: Int {
    case oneS = 0
    case oneM = 1
    case oneL = 2
    case twoS = 3
    case twoM = 4
    case threeS = 5

}

enum color: Int {
    case blue = 0
    case red = 1
    case purple = 2
    case yellow = 3
    case orange = 4
}

class GlobalData {
   static var score = 0
}

extension GameScene {
    
    func addPlayer() {
        player.position = CGPoint(x: self.size.width / 2, y:350)
        player.name = "player"
        player.physicsBody?.isDynamic = false
        player.physicsBody = SKPhysicsBody(circleOfRadius: 35)
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.categoryBitMask = CollisionBitmask.Player
        player.physicsBody?.contactTestBitMask = CollisionBitmask.Obstacle
        self.addChild(player)
        
        player2.position = CGPoint(x: self.size.width / 2, y: 350)
        player2.name = "player2"
        player2.physicsBody?.isDynamic = false
        player2.physicsBody = SKPhysicsBody(circleOfRadius: 35)

        player2.physicsBody?.collisionBitMask = 0
        player2.physicsBody?.categoryBitMask = CollisionBitmask.Player
        player2.physicsBody?.contactTestBitMask = CollisionBitmask.Obstacle
        
        self.addChild(player2)
        
        initialPlayerPosiiton = player.position

    }
    
    func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 0.74)
    }
    
    
    func addObstacle (_ type:ObstacleType) -> SKSpriteNode {
        let obstacle = SKSpriteNode(color: randomColor(), size: CGSize(width: 0, height: 76))
        obstacle.name = "obstacle"
        obstacle.physicsBody?.isDynamic = true
        obstacle.physicsBody?.contactTestBitMask = CollisionBitmask.Player
        obstacle.physicsBody?.categoryBitMask = CollisionBitmask.Obstacle
        obstacle.physicsBody?.collisionBitMask = 0
        

        
        switch type {
        case .small :
            obstacle.size.width = self.size.width * 0.2
            break
        case .medium :
            obstacle.size.width = self.size.width * 0.41
            break
        case .large :
            obstacle.size.width = self.size.width * 0.715
            break
            
        }
        
        obstacle.position = CGPoint(x: 0, y : self.size.height)
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = CollisionBitmask.Obstacle
        obstacle.physicsBody?.collisionBitMask = 0
        
        return obstacle
    }
    
       func addMovement (_ obstacle:SKSpriteNode) {
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: obstacle.position.x, y : -obstacle.size.height), duration: TimeInterval(2.85)))
        actionArray.append(SKAction.removeFromParent())
        
        obstacle.run(SKAction.sequence(actionArray))
    }
    
    
    func addRow (_ type:RowType) {
        switch type {
        case .oneS:
            let obst = addObstacle(.small)
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            addMovement(obst)
            addChild(obst)
            break
        case .oneM:
            let obst = addObstacle(.medium)
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            addMovement(obst)
            addChild(obst)
            break
            
        case .oneL:
            let obst = addObstacle(.large)
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            addMovement(obst)
            addChild(obst)
            break
            
        case .twoS:
            let obst1 = addObstacle(.small)
             let obst2 = addObstacle(.small)
            
            obst1.position = CGPoint(x: obst1.size.width + 45, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst2.size.width - 45, y: obst1.position.y)
            
            addMovement(obst1)
            addMovement(obst2)
            
            addChild(obst1)
            addChild(obst2)
            break
        case .twoM:
            let obst1 = addObstacle(.medium)
            let obst2 = addObstacle(.medium)

            obst1.position = CGPoint(x: obst1.size.width / 2 + 30, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst2.size.width / 2 - 30, y: obst1.position.y)
            
            addMovement(obst1)
            addMovement(obst2)
            
            addChild(obst1)
            addChild(obst2)

            break
        case .threeS:
            let obst1 = addObstacle(.small)
            let obst2 = addObstacle(.small)
            let obst3 = addObstacle(.small)
            
            obst1.position = CGPoint(x: obst1.size.width / 2 + 50, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst2.size.width / 2 - 50, y: obst1.position.y)
            obst3.position = CGPoint(x: self.size.width / 2 , y: obst1.position.y)
            
            addMovement(obst1)
            addMovement(obst2)
            addMovement(obst3)
            
            addChild(obst1)
            addChild(obst2)
            addChild(obst3)
            break
            
        }
    }
}



        
