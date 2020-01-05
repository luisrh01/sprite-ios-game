//
//  GameScene.swift
//  Snake
//
//  Created by Luis Hernandez on 1/4/20.
//  Copyright © 2020 BPS Consulting. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //1
    var gameLogo: SKLabelNode!
    var bestScore: SKLabelNode!
    var playButton: SKShapeNode!
    //1
    var game: GameManager!
    
    override func didMove(to view: SKView) {
        //2
        initializeMenu()
        //2
        game = GameManager()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    //3
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                if node.name == "play_button" {
                    startGame()
                }
            }
        }
    }
    //4
    //start the game
    private func startGame() {
        print("start game")
        //1
        gameLogo.run(SKAction.move(by: CGVector(dx: -50, dy: 600), duration: 0.5)) {
        self.gameLogo.isHidden = true
        }
        //2
        playButton.run(SKAction.scale(to: 0, duration: 0.3)) {
            self.playButton.isHidden = true
        }
        //3
        let bottomCorner = CGPoint(x: 0, y: (frame.size.height / -2) + 20)
        bestScore.run(SKAction.move(to: bottomCorner, duration: 0.4))
    }
    //3
    private func initializeMenu() {
        //Create game title
        gameLogo = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        gameLogo.zPosition = 1
        gameLogo.position = CGPoint(x: 0, y: (frame.size.height / 2) - 200)
        gameLogo.fontSize = 60
        gameLogo.text = "SNAKE"
        gameLogo.fontColor = SKColor.red
        self.addChild(gameLogo)
        //Create best score label
        bestScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        bestScore.zPosition = 1
        bestScore.position = CGPoint(x: 0, y: gameLogo.position.y - 50)
        bestScore.fontSize = 40
        bestScore.text = "Best Score: 0"
        bestScore.fontColor = SKColor.white
        self.addChild(bestScore)
        //Create play button
        playButton = SKShapeNode()
        playButton.name = "play_button"
        playButton.zPosition = 1
        playButton.position = CGPoint(x: 0, y: (frame.size.height / -2) + 200)
        playButton.fillColor = SKColor.cyan
        let topCorner = CGPoint(x: -50, y: 50)
        let bottomCorner = CGPoint(x: -50, y: -50)
        let middle = CGPoint(x: 50, y: 0)
        let path = CGMutablePath()
        path.addLine(to: topCorner)
        path.addLines(between: [topCorner, bottomCorner, middle])
        playButton.path = path
        self.addChild(playButton)
    }
    
    
    
    
    
    
    
}
