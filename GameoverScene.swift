//
//  GameoverScene.swift
//  Tappy Lights
//
//  Created by Brian Lim on 6/15/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import GameKit

class GameoverScene: SKScene, GKGameCenterControllerDelegate {
    
    var bg = SKSpriteNode()
    var title = SKLabelNode()
    var playBtn = SKSpriteNode()
    var rateBtn = SKSpriteNode()
    var leaderboardBtn = SKSpriteNode()
    var musicBtn = SKSpriteNode()
    var homeBtn = SKSpriteNode()
    
    var scoreTitle = SKLabelNode()
    var scoreLbl = SKLabelNode()
    
    var recordTitle = SKLabelNode()
    var recordLbl = SKLabelNode()
    
    var userScore = 0
    var userHighscore = 0
    
    var shouldAnimate = false
    
    override func didMoveToView(view: SKView) {
        adShown += 1
        
        checkScore()
        initialize()
        waitBeforeShowingAd()
        
        if soundOn == true {
            
            musicBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOn")))
        } else {
            
            musicBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOff")))
        }
    }
    
    func initialize() {
        
        setTitle()
        createPlayBtn()
        createScoreAndRecordLbls()
        createHomeBtn()
        createRateBtn()
        createMusicBtn()
        createLeaderboardBtn()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location) == playBtn {
                
                playSound2()
                
                let gameplay = GameplayScene(fileNamed: "GameplayScene")
                gameplay?.scaleMode = .AspectFill
                self.view?.presentScene(gameplay!, transition: SKTransition.fadeWithDuration(0.5))
            }
            
            if nodeAtPoint(location) == homeBtn {
                
                playSound3()
                
                let mainMenu = MainMenuScene(fileNamed: "MainMenuScene")
                mainMenu?.scaleMode = .AspectFill
                self.view?.presentScene(mainMenu!, transition: SKTransition.fadeWithDuration(0.5))
            }
            
            if nodeAtPoint(location) == rateBtn {
                
                playSound3()
                rateBtnPressed()
                
            }
            
            if nodeAtPoint(location) == musicBtn {
                
                playSound3()
                soundBtnPressed()
            }
            
            if nodeAtPoint(location) == leaderboardBtn {
                
                playSound3()
                leaderboardBtnPressed()
            }
            
            
        }
    }
    
    func checkScore() {
        
        // Checking to see if there is a integer for the key "SCORE"
        if let score: Int = NSUserDefaults.standardUserDefaults().integerForKey("SCORE") {
            userScore = score
            
            // Checking to see if there if a integer for the key "HIGHSCORE"
            if let highscore: Int = NSUserDefaults.standardUserDefaults().integerForKey("HIGHSCORE") {
                
                // If there is, check if the current score is greater then the value of the current highscore
                if score > highscore {
                    // If it is, set the current score as the new high score
                    GameManager.instance.setHighscore(score)
                    userHighscore = score
                    saveHighscore(score)
                    shouldAnimate = true
                    
                } else {
                    // Score is not greater then highscore
                }
            } else {
                // There is no integer for the key "HIGHSCORE"
                // Set the current score as the highscore since there is no value for highscore yet
                GameManager.instance.setHighscore(score)
                userHighscore = score
                saveHighscore(score)
                shouldAnimate = true
                
            }
        }
        
        // Checking to see if there a integer for the key "HIGHSCORE"
        if let highscore: Int = NSUserDefaults.standardUserDefaults().integerForKey("HIGHSCORE") {
            // If so, then set the value of this key to the userHighscore variable
            userHighscore = highscore
        }
        
    }
    
    func setTitle() {
        
        title = SKLabelNode(fontNamed: "Prototype")
        title.name = "Title"
        title.zPosition = 2
        title.fontSize = 160
        title.fontColor = SKColor.whiteColor()
        title.text = "GAMEOVER"
        
        if UIDevice().userInterfaceIdiom == .Phone {
            switch UIScreen.mainScreen().nativeBounds.height {
                
            case 480:
                print("iPhone Classic")
            case 960:
                // iPhone 4 or 4S
                title.position = CGPoint(x: 0, y: 600)
                
            case 1136:
                // iPhone 5 or 5S or 5C
                title.position = CGPoint(x: 0, y: 740)
                
            case 1334:
                // iPhone 6 or 6S
                title.position = CGPoint(x: 0, y: 740)
                
            case 2208:
                // iPhone 6+ or 6S+
                title.position = CGPoint(x: 0, y: 760)
                
            default:
                print("unknown")
            }
            
        }
        
        self.addChild(title)
    }
    
    func createScoreAndRecordLbls() {
        
        scoreTitle = SKLabelNode(fontNamed: "Prototype")
        scoreTitle.zPosition = 2
        scoreTitle.fontSize = 80
        scoreTitle.fontColor = SKColor.whiteColor()
        scoreTitle.text = "SCORE"
        scoreTitle.position = CGPoint(x: playBtn.position.x - 330, y: 200)
        
        scoreLbl = SKLabelNode(fontNamed: "Prototype")
        scoreLbl.zPosition = 2
        scoreLbl.fontSize = 90
        scoreLbl.fontColor = SKColor.whiteColor()
        scoreLbl.text = "\(userScore)"
        scoreLbl.position = CGPoint(x: playBtn.position.x - 330, y: scoreTitle.position.y - 150)
        
        recordTitle = SKLabelNode(fontNamed: "Prototype")
        recordTitle.zPosition = 2
        recordTitle.fontSize = 80
        recordTitle.fontColor = SKColor.whiteColor()
        recordTitle.text = "RECORD"
        recordTitle.position = CGPoint(x: playBtn.position.x + 330, y: 200)
        
        recordLbl = SKLabelNode(fontNamed: "Prototype")
        recordLbl.zPosition = 2
        recordLbl.fontSize = 90
        recordLbl.fontColor = SKColor.whiteColor()
        recordLbl.text = "\(userHighscore)"
        recordLbl.position = CGPoint(x: playBtn.position.x + 330, y: scoreTitle.position.y - 150)
        if shouldAnimate == true {
            let fadeOut = SKAction.fadeAlphaTo(0.0, duration: 0.5)
            let fadeIn = SKAction.fadeAlphaTo(1.0, duration: 0.5)
            recordLbl.runAction(SKAction.repeatActionForever(SKAction.sequence([fadeOut, fadeIn])))
        }
        
        self.addChild(scoreTitle)
        self.addChild(recordTitle)
        
        self.addChild(scoreLbl)
        self.addChild(recordLbl)
    }
    
    func createPlayBtn() {
        
        playBtn = SKSpriteNode(imageNamed: "PlayBtn")
        playBtn.name = "Play"
        playBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        playBtn.zPosition = 3
        playBtn.size = CGSize(width: 300, height: 300)
        playBtn.position = CGPoint(x: 0, y: 0)
        
        let scaleUp = SKAction.scaleTo(1.1, duration: 0.5)
        let scaleDown = SKAction.scaleTo(1.0, duration: 0.5)
        
        playBtn.runAction(SKAction.repeatActionForever(SKAction.sequence([scaleUp, scaleDown])))
        
        self.addChild(playBtn)
    }
    
    func createHomeBtn() {
        
        homeBtn = SKSpriteNode(imageNamed: "HomeBtn")
        homeBtn.name = "RemoveAds"
        homeBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        homeBtn.zPosition = 3
        homeBtn.size = CGSize(width: 150, height: 150)
        homeBtn.position = CGPoint(x: -330, y: playBtn.position.y - 650)
        
        self.addChild(homeBtn)
    }
    
    func createRateBtn() {
        
        rateBtn = SKSpriteNode(imageNamed: "RateBtn")
        rateBtn.name = "Rate"
        rateBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rateBtn.zPosition = 3
        rateBtn.size = CGSize(width: 150, height: 150)
        rateBtn.position = CGPoint(x: -110, y: playBtn.position.y - 650)
        
        self.addChild(rateBtn)
    }
    
    func createLeaderboardBtn() {
        
        leaderboardBtn = SKSpriteNode(imageNamed: "LeaderboardBtn")
        leaderboardBtn.name = "Leaderboard"
        leaderboardBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leaderboardBtn.zPosition = 3
        leaderboardBtn.size = CGSize(width: 150, height: 150)
        leaderboardBtn.position = CGPoint(x: 110, y: playBtn.position.y - 650)
        
        self.addChild(leaderboardBtn)
    }
    
    func createMusicBtn() {
        
        musicBtn = SKSpriteNode(imageNamed: "MusicBtnOn")
        musicBtn.name = "Music"
        musicBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        musicBtn.zPosition = 3
        musicBtn.size = CGSize(width: 150, height: 150)
        musicBtn.position = CGPoint(x: 330, y: playBtn.position.y - 650)
        
        self.addChild(musicBtn)
    }
    
    func rateBtnPressed() {
        
        let wait = SKAction.waitForDuration(0.1)
        let run = SKAction.runBlock {
            
            UIApplication.sharedApplication().openURL(NSURL(string: "itms-apps://itunes.apple.com/app/id1125785641")!)
        }
        
        self.runAction(SKAction.sequence([wait, run]))
    }
    
    func soundBtnPressed() {
        if soundOn == true {
            musicBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOff")))
            soundOn = false
            // Sound is OFF
        } else {
            musicBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOn")))
            soundOn = true
            // Sound is ON
        }
    }
    
    func leaderboardBtnPressed() {
        let gcVC: GKGameCenterViewController = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = GKGameCenterViewControllerState.Leaderboards
        gcVC.leaderboardIdentifier = "TappyLights_2016"
        self.view?.window?.rootViewController?.presentViewController(gcVC, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //send high score to leaderboard
    func saveHighscore(score:Int) {
        
        //check if user is signed in
        if GKLocalPlayer.localPlayer().authenticated {
            
            let scoreReporter = GKScore(leaderboardIdentifier: "TappyLights_2016") //leaderboard id here
            
            scoreReporter.value = Int64(score) //score variable here (same as above)
            
            let scoreArray: [GKScore] = [scoreReporter]
            
            GKScore.reportScores(scoreArray, withCompletionHandler: {(error : NSError?) -> Void in
                if error != nil {
                    // error
                }
            })
            
        }
        
        
    }
    
    func waitBeforeShowingAd() {
        let wait = SKAction.waitForDuration(0.5)
        let run = SKAction.runBlock {
            
            NSNotificationCenter.defaultCenter().postNotificationName("showInterstitialKey", object: nil)
        }
        let sequence = SKAction.sequence([wait, run])
        self.runAction(sequence)
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
}




















