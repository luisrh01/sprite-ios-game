//
//  GameScene.swift
//  Snake
//
//  Created by Luis Hernandez on 1/4/20.
//  Copyright © 2020 BPS Consulting. All rights reserved.
//

/*
 based on :
 
 https://medium.com/@gavin9/how-to-build-an-iphone-game-from-scratch-using-spritekit-no-coding-experience-required-bf486568075a
*/

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //1
    var gameLogo: SKLabelNode!
    var bestScore: SKLabelNode!
    var playButton: SKShapeNode!
    //1
    var game: GameManager!
    //1
    var currentScore: SKLabelNode!
    var playerPositions: [(Int, Int)] = []
    var gameBG: SKShapeNode!
    var gameArray: [(node: SKShapeNode, x: Int, y: Int)] = []
    
    override func didMove(to view: SKView) {
        initializeMenu()
        game = GameManager(scene: self)
        initializeGameView()
        
    }

    private func initializeGameView() {

        currentScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        currentScore.zPosition = 1
        currentScore.position = CGPoint(x: 0, y: (frame.size.height / -2) + 60)
        currentScore.fontSize = 40
        currentScore.isHidden = true
        currentScore.text = "Score: 0"
        currentScore.fontColor = SKColor.white
        self.addChild(currentScore)

        let width = frame.size.width - 200
        let height = frame.size.height - 300
        let rect = CGRect(x: -width / 2, y: -height / 2, width: width, height: height)
        gameBG = SKShapeNode(rect: rect, cornerRadius: 0.02)
        gameBG.fillColor = SKColor.darkGray
        gameBG.zPosition = 2
        gameBG.isHidden = true
        self.addChild(gameBG)

        createGameBoard(width: Int(width), height: Int(height))
    }
    
    //create a game board, initialize array of cells
    private func createGameBoard(width: Int, height: Int) {
        let cellWidth: CGFloat = 27.5
        let numRows = 40
        let numCols = 20
        var x = CGFloat(width / -2) + (cellWidth / 2)
        var y = CGFloat(height / 2) - (cellWidth / 2)
        //loop through rows and columns, create cells
        for i in 0...numRows - 1 {
            for j in 0...numCols - 1 {
                let cellNode = SKShapeNode(rectOf: CGSize(width: cellWidth, height: cellWidth))
                cellNode.strokeColor = SKColor.black
                cellNode.zPosition = 2
                cellNode.position = CGPoint(x: x, y: y)
                //add to array of cells -- then add to game board
                gameArray.append((node: cellNode, x: i, y: j))
                gameBG.addChild(cellNode)
                //iterate x
                x += cellWidth
            }
            //reset x, iterate y
            x = CGFloat(width / -2) + (cellWidth / 2)
            y -= cellWidth
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        game.update(time: currentTime)

    }

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
        
        bestScore.run(SKAction.move(to: bottomCorner, duration: 0.4)) {
            self.gameBG.setScale(0)
            self.currentScore.setScale(0)
            self.gameBG.isHidden = false
            self.currentScore.isHidden = false
            self.gameBG.run(SKAction.scale(to: 1, duration: 0.4))
            self.currentScore.run(SKAction.scale(to: 1, duration: 0.4))

            self.game.initGame()

        }
    }
    

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
