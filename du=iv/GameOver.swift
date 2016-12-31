//
//  GameOver.swift
//  du=iv
//
//  Created by luis castillo on 8/2/16.
//  Copyright © 2016 luis castillo. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    
    }



override init(size: CGSize) {
    
    super.init(size: size)
    self.backgroundColor = SKColor.white
    let message = "Game Over"
    
    let label = SKLabelNode(fontNamed: "Helvetica")
    label.text = message
    label.fontSize = 155
    label.fontColor = SKColor.black
    label.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.8)
    addChild(label)
    
    let image = SKSpriteNode(imageNamed: "circle")
    image.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.5)
    addChild(image)
    
    let defaults = UserDefaults.standard
    let score = defaults.integer(forKey: "scoreKey")
    
    
    let scoreLabel = SKLabelNode(fontNamed: "Helvetica")
    scoreLabel.position = CGPoint(x: image.size.height / 1.9, y: self.size.height * 0.55)
    scoreLabel.fontSize = 200
    scoreLabel.zPosition = 2
    scoreLabel.fontColor = SKColor.white
    addChild(scoreLabel)
    
    scoreLabel.text = "\(score)"
    
    
    let highscoreLabel = SKLabelNode(fontNamed: "Helvetica")
    highscoreLabel.position = CGPoint(x: image.size.height / 1.9, y: self.size.height * 0.39)
    highscoreLabel.fontColor = SKColor.white
    highscoreLabel.fontSize = 200
    highscoreLabel.zPosition = 2
    addChild(highscoreLabel)
    //highscoreLabel.text = "0"
    let currentHighScore = UserDefaults.standard.integer(forKey: "highscore")
    defaults.synchronize()
    defaults.setValue(currentHighScore, forKey: "highscore")
  
    
    if (score > currentHighScore) {
        
        UserDefaults.standard.set(score,forKey: "highscore")
        
        UserDefaults.standard.synchronize()
        
        highscoreLabel.text = "\(score)"
        
    } else {
        
        highscoreLabel.text = "\(currentHighScore)"
    }

    
    
    

}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.flipVertical(withDuration: 0.5)
        let skView = self.view as SKView!
        let gameScene = GameScene(fileNamed:"GameScene") as GameScene!
        gameScene?.scaleMode = .fill
        skView?.presentScene(gameScene!, transition: transition)

    }
}
    
