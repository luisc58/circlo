//
//  GameViewController.swift
//  du=iv
//
//  Created by luis castillo on 8/1/16.
//  Copyright (c) 2016 luis castillo. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation


class GameViewController: UIViewController {
    
    var backgroundMusicPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed:"GameScene") {
            
            let bgMusicURL = Bundle.main.url(forResource: "novax", withExtension: "mp3")
            
            do {
                try backgroundMusicPlayer = AVAudioPlayer(contentsOf:bgMusicURL! )
            } catch {print("cant play music")}
            
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
             //Configure; the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            skView.presentScene(scene)
        }
    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
