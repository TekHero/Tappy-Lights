//
//  GameplayScene.swift
//  Tappy Lights
//
//  Created by Brian Lim on 6/15/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class GameplayScene: SKScene {
    
    var scoreLbl = SKLabelNode()
    var pauseBtn = SKSpriteNode()
    
    var bg = SKSpriteNode()
    var pauseScreen = SKSpriteNode()
    var pauseTitle = SKLabelNode()
    var continueTitle = SKLabelNode()
    
    var containerProgressBar = SKSpriteNode()
    var progressBar = SKSpriteNode()
    
    var firstBtn = LightButton()
    var secondBtn = LightButton()
    var thirdBtn = LightButton()
    var fourthBtn = LightButton()
    var fifthBtn = LightButton()
    var sixthBtn = LightButton()
    var seventhBtn = LightButton()
    var eighthBtn = LightButton()
    var ninthBtn = LightButton()
    
    var btnDownSize = CGSize(width: 200, height: 200) // CGSize(width: 250, height: 270)
    var btnUpSize = CGSize(width: 200, height: 220) // CGSize(width: 270, height: 340)
    
    var counter = 0
    
    override func didMoveToView(view: SKView) {
        
        initialize()
    }
    
    func initialize() {
    
        createScoreLbl()
        createFirstBtn()
        createSecondBtn()
        createThirdBtn()
        createFourthBtn()
        createFifthBtn()
        createSixthBtn()
        createSeventhBtn()
        createEigthBtn()
        createNinthBtn()
        createPauseBtn()
        createProgressBarAndContainer()
        
        callChangeTextures()
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        if self.scene?.paused == false && containerProgressBar.size.width >= 1 {
            
            containerProgressBar.size.width -= 1
            
        }
        
        if containerProgressBar.size.width <= 0 {
            
            // Gameover
            endGame()
        }
        
        if containerProgressBar.size.width >= 500 && containerProgressBar.size.width <= 600 {
            
            containerProgressBar.color = UIColor.greenColor()
        }
        
        if containerProgressBar.size.width >= 200 && containerProgressBar.size.width <= 300 {
            
            containerProgressBar.color = UIColor.redColor()
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            if self.scene?.paused == false {
                
                if nodeAtPoint(location) == firstBtn {
                    
                    checkTexture(firstBtn)
                }
                
                if nodeAtPoint(location) == secondBtn {
                    
                    checkTexture(secondBtn)
                }
                
                if nodeAtPoint(location) == thirdBtn {
                    
                    checkTexture(thirdBtn)
                }
                
                if nodeAtPoint(location) == fourthBtn {
                    
                    checkTexture(fourthBtn)
                }
                
                if nodeAtPoint(location) == fifthBtn {
                    
                    checkTexture(fifthBtn)
                }
                
                if nodeAtPoint(location) == sixthBtn {
                    
                    checkTexture(sixthBtn)
                }
                
                if nodeAtPoint(location) == seventhBtn {
                    
                    checkTexture(seventhBtn)
                }
                
                if nodeAtPoint(location) == eighthBtn {
                    
                    checkTexture(eighthBtn)
                }
                
                if nodeAtPoint(location) == ninthBtn {
                    
                    checkTexture(ninthBtn)
                }
                
            }
            
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location) == pauseBtn {
                
                if self.scene?.paused == false {
                    
                    self.scene?.paused = true
                    self.createPauseScreen()
                } else {
                    
                    self.scene?.paused = false
                }
            }
            
            if nodeAtPoint(location) == continueTitle {
                
                self.scene?.paused = false
                self.pauseScreen.removeFromParent()
                self.pauseTitle.removeFromParent()
                self.continueTitle.removeFromParent()
            }
        }
    }
    
    func checkTexture(btn: SKSpriteNode) {
        
        if btn.size == btnUpSize {
            
            playSound1()
            containerProgressBar.size.width += 12
            updateScoreLbl()
            btn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Down"))) // White Button Down
            btn.size = btnDownSize
            
            if btn == firstBtn {
                
                btn.position = CGPoint(x: -300, y: 250)
                
            }
            
            if btn == secondBtn {
                
                btn.position = CGPoint(x: 0, y: 250)
            }
            
            if btn == thirdBtn {
                
                btn.position = CGPoint(x: 300, y: 250)
            }
            
            if btn == fourthBtn {
                
                btn.position = CGPoint(x: -300, y: -120)
            }
            
            if btn == fifthBtn {
                
                btn.position = CGPoint(x: 0, y: -120)
                
            }
            
            if btn == sixthBtn {
                
                btn.position = CGPoint(x: 300, y: -120)
                
            }
            
            if btn == seventhBtn {
                
                btn.position = CGPoint(x: -300, y: -500)
                
            }
            
            if btn == eighthBtn {
                
                btn.position = CGPoint(x: 0, y: -500)
                
            }
            
            if btn == ninthBtn {
                
                btn.position = CGPoint(x: 300, y: -500)
            }
            
            
        } else {
            
            // Gameover
            playSound4()
            endGame()
        }
    }
    
    func updateScoreLbl() {
        
        counter += 1
        scoreLbl.text = "\(counter)"
    }
    
    func callChangeTextures() {
        
        let wait = SKAction.waitForDuration(1.0)
        let run = SKAction.runBlock {
            
            self.changeTextures()
        }
        
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait, run])))
    }
    
    func changeTextures() {
        
        let rand = arc4random_uniform(30)
        let rand2 = arc4random_uniform(30)
        let rand3 = arc4random_uniform(30)
        let rand4 = arc4random_uniform(30)
        let rand5 = arc4random_uniform(30)
        let rand6 = arc4random_uniform(30)
        let rand7 = arc4random_uniform(30)
        let rand8 = arc4random_uniform(30)
        let rand9 = arc4random_uniform(30)
        
        if rand % 2 == 0 {
            
            firstBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Up"))) // White Button Up
            firstBtn.size = btnUpSize
        } else {
            
            firstBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Down"))) // White Button Down
            firstBtn.size = btnDownSize
        }
        
        if rand2 % 2 == 0 {
            
            secondBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Up"))) // White Button Up
            secondBtn.size = btnUpSize
        } else {
            
            secondBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Down"))) // White Button Down
            secondBtn.size = btnDownSize
        }
        
        if rand3 % 2 == 0 {
            
            thirdBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Up"))) // White Button Up
            thirdBtn.size = btnUpSize
        } else {
            
            thirdBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Down"))) // White Button Down
            thirdBtn.size = btnDownSize
        }
        
        if rand4 % 2 == 0 {
            
            fourthBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Up"))) // White Button Up
            fourthBtn.size = btnUpSize
        } else {
            
            fourthBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Down"))) // White Button Down
            fourthBtn.size = btnDownSize
        }
        
        if rand5 % 2 == 0 {
            
            fifthBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Up"))) // White Button Up
            fifthBtn.size = btnUpSize
        } else {
            
            fifthBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Down"))) // White Button Down
            fifthBtn.size = btnDownSize
        }
        
        if rand6 % 2 == 0 {
            
            sixthBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Up"))) // White Button Up
            sixthBtn.size = btnUpSize
        } else {
            
            sixthBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Down"))) // White Button Down
            sixthBtn.size = btnDownSize
        }
        
        if rand7 % 2 == 0 {
            
            seventhBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Up"))) // White Button Up
            seventhBtn.size = btnUpSize
        } else {
            
            seventhBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Down"))) // White Button Down
            seventhBtn.size = btnDownSize
        }
        
        if rand8 % 2 == 0 {
            
            eighthBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Up"))) // White Button Up
            eighthBtn.size = btnUpSize
        } else {
            
            eighthBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Down"))) // White Button Down
            eighthBtn.size = btnDownSize
        }
        
        if rand9 % 2 == 0 {
            
            ninthBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Up"))) // White Button Up
            ninthBtn.size = btnUpSize
        } else {
            
            ninthBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "ButtonV2Down"))) // White Button Down
            ninthBtn.size = btnDownSize
        }
        
    }
    
    func createBG() {
        
        bg = SKSpriteNode(imageNamed: "Black")
        bg.name = "BG"
        bg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        bg.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        bg.zPosition = 1
        bg.position = CGPoint(x: 0, y: 0)
        
        self.addChild(bg)
    }
    
    func createProgressBarAndContainer() {
        
        containerProgressBar = SKSpriteNode(color: UIColor.cyanColor(), size: CGSize(width: (self.scene?.size.width)! - 100, height: 10))
        containerProgressBar.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        containerProgressBar.zPosition = 3
        containerProgressBar.name = "Container"
        containerProgressBar.position = CGPoint(x: 0, y: scoreLbl.position.y - 100)
        
        self.addChild(containerProgressBar)
    }
    
    func createScoreLbl() {
        
        scoreLbl = SKLabelNode(fontNamed: "Prototype")
        scoreLbl.fontSize = 260
        scoreLbl.fontColor = SKColor.whiteColor().colorWithAlphaComponent(0.6)
        scoreLbl.zPosition = 2
        scoreLbl.position = CGPoint(x: 0, y: 650)
        scoreLbl.text = "0"
        
        if UIDevice().userInterfaceIdiom == .Phone {
            switch UIScreen.mainScreen().nativeBounds.height {
                
            case 480:
                print("iPhone Classic")
            case 960:
                // iPhone 4 or 4S
                scoreLbl.position = CGPoint(x: 0, y: 580)

            case 1136:
                // iPhone 5 or 5S or 5C
                scoreLbl.position = CGPoint(x: 0, y: 650)

            case 1334:
                // iPhone 6 or 6S
                scoreLbl.position = CGPoint(x: 0, y: 650)
                
            case 2208:
                // iPhone 6+ or 6S+
                scoreLbl.position = CGPoint(x: 0, y: 650)
            default:
                print("unknown")
            }
        }
        
        self.addChild(scoreLbl)
    }
    
    func createPauseBtn() {
        
        pauseBtn = SKSpriteNode(imageNamed: "PauseBtn")
        pauseBtn.name = "Pause"
        pauseBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pauseBtn.zPosition = 2
        pauseBtn.size = CGSize(width: 100, height: 100)
        
        if UIDevice().userInterfaceIdiom == .Phone {
            switch UIScreen.mainScreen().nativeBounds.height {
                
            case 480:
                print("iPhone Classic")
            case 960:
                // iPhone 4 or 4S
                pauseBtn.position = CGPoint(x: CGRectGetMaxX(self.frame) - 100, y: CGRectGetMaxY(self.frame) - 230)
            case 1136:
                // iPhone 5 or 5S or 5C
                pauseBtn.position = CGPoint(x: CGRectGetMaxX(self.frame) - 100, y: CGRectGetMaxY(self.frame) - 100)
                
            case 1334:
                // iPhone 6 or 6S
                pauseBtn.position = CGPoint(x: CGRectGetMaxX(self.frame) - 100, y: CGRectGetMaxY(self.frame) - 100)
                
            case 2208:
                // iPhone 6+ or 6S+
                pauseBtn.position = CGPoint(x: CGRectGetMaxX(self.frame) - 100, y: CGRectGetMaxY(self.frame) - 100)
            default:
                print("unknown")
            }
        }
        
        self.addChild(pauseBtn)
    }
    
    func createPauseScreen() {
        
        pauseScreen = SKSpriteNode(color: UIColor.blackColor().colorWithAlphaComponent(0.6), size: CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!))
        pauseScreen.name = "PauseScreen"
        pauseScreen.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pauseScreen.zPosition = 15
        pauseScreen.position = CGPoint(x: 0, y: 0)
        
        pauseTitle = SKLabelNode(fontNamed: "Prototype")
        pauseTitle.name = "PauseTitle"
        pauseTitle.position = CGPoint(x: 0, y: 500)
        pauseTitle.fontSize = 80
        pauseTitle.fontColor = SKColor.whiteColor()
        pauseTitle.text = "PAUSE"
        pauseTitle.zPosition = 16
        
        continueTitle = SKLabelNode(fontNamed: "Prototype")
        continueTitle.name = "ContinueTitle"
        continueTitle.position = CGPoint(x: 0, y: 0)
        continueTitle.fontSize = 90
        continueTitle.fontColor = SKColor.whiteColor()
        continueTitle.text = "TAP TO CONTINUE"
        continueTitle.zPosition = 16
        
        self.addChild(pauseScreen)
        pauseScreen.addChild(pauseTitle)
        pauseScreen.addChild(continueTitle)
    }
    
    func createFirstBtn() {
        
        firstBtn = LightButton(imageNamed: "ButtonV2Down") // White Button Down
        firstBtn.name = "First"
        firstBtn.size = btnDownSize
        firstBtn.initialize()
        firstBtn.position = CGPoint(x: -300, y: 250)
        
        self.addChild(firstBtn)
    }
    
    func createSecondBtn() {
        
        secondBtn = LightButton(imageNamed: "ButtonV2Down") // White Button Down
        secondBtn.name = "Second"
        secondBtn.size = btnDownSize
        secondBtn.initialize()
        secondBtn.position = CGPoint(x: 0, y: 250)
        
        self.addChild(secondBtn)
    }
    
    func createThirdBtn() {
        
        thirdBtn = LightButton(imageNamed: "ButtonV2Down") // White Button Down
        thirdBtn.name = "Third"
        thirdBtn.size = btnDownSize
        thirdBtn.initialize()
        thirdBtn.position = CGPoint(x: 300, y: 250)
        
        self.addChild(thirdBtn)
    }
    
    func createFourthBtn() {
        
        fourthBtn = LightButton(imageNamed: "ButtonV2Down") // White Button Down
        fourthBtn.name = "Fourth"
        fourthBtn.size = btnDownSize
        fourthBtn.initialize()
        fourthBtn.position = CGPoint(x: -300, y: -120)
        
        self.addChild(fourthBtn)
    }
    
    func createFifthBtn() {
        
        fifthBtn = LightButton(imageNamed: "ButtonV2Down") // White Button Down
        fifthBtn.name = "Fifth"
        fifthBtn.size = btnDownSize
        fifthBtn.initialize()
        fifthBtn.position = CGPoint(x: 0, y: -120)
        
        self.addChild(fifthBtn)
    }
    
    func createSixthBtn() {
        
        sixthBtn = LightButton(imageNamed: "ButtonV2Down") // White Button Down
        sixthBtn.name = "Sixth"
        sixthBtn.size = btnDownSize
        sixthBtn.initialize()
        sixthBtn.position = CGPoint(x: 300, y: -120)
        
        self.addChild(sixthBtn)
    }
    
    func createSeventhBtn() {
        
        seventhBtn = LightButton(imageNamed: "ButtonV2Down") // White Button Down
        seventhBtn.name = "Seventh"
        seventhBtn.size = btnDownSize
        seventhBtn.initialize()
        seventhBtn.position = CGPoint(x: -300, y: -500)
        
        self.addChild(seventhBtn)
    }
    
    func createEigthBtn() {
        
        eighthBtn = LightButton(imageNamed: "ButtonV2Down") // White Button Down
        eighthBtn.name = "Eigth"
        eighthBtn.size = btnDownSize
        eighthBtn.initialize()
        eighthBtn.position = CGPoint(x: 0, y: -500)
        
        self.addChild(eighthBtn)
    }
    
    func createNinthBtn() {
        
        ninthBtn = LightButton(imageNamed: "ButtonV2Down") // White Button Down
        ninthBtn.name = "Ninth"
        ninthBtn.size = btnDownSize
        ninthBtn.initialize()
        ninthBtn.position = CGPoint(x: 300, y: -500)
        
        self.addChild(ninthBtn)
    }
    
    func endGame() {
        
        NSUserDefaults.standardUserDefaults().setInteger(counter, forKey: "SCORE")
        
        let wait = SKAction.waitForDuration(0.2)
        let run = SKAction.runBlock {
            
            self.removeAllActions()
            self.removeAllChildren()
            let gameover = GameoverScene(fileNamed: "GameoverScene")
            gameover?.scaleMode = .AspectFill
            self.view?.presentScene(gameover!, transition: SKTransition.fadeWithDuration(0.5))
        }
        self.runAction(SKAction.sequence([wait, run]))
        
    }
    
    func playSound1() {
        
        let play = SKAction.playSoundFileNamed("ButtonClicked1", waitForCompletion: false)
        if soundOn == true {
            self.runAction(play)
        }
    }
    
    func playSound2() {
        
        let play = SKAction.playSoundFileNamed("ButtonSelect1", waitForCompletion: false)
        if soundOn == true {
            self.runAction(play)
        }
    }
    
    func playSound3() {
        
        let play = SKAction.playSoundFileNamed("Menu Selection Click", waitForCompletion: false)
        if soundOn == true {
            self.runAction(play)
        }
    }
    
    func playSound4() {
        
        let play = SKAction.playSoundFileNamed("WrongHit1", waitForCompletion: false)
        if soundOn == true {
            self.runAction(play)
        }
    }
    
    
}
















