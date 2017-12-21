//
//  MainMenuScene.swift
//  Tappy Lights
//
//  Created by Brian Lim on 6/14/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import GameKit

class MainMenuScene: SKScene, GKGameCenterControllerDelegate {
    
    var title = SKLabelNode()
    var playBtn = SKSpriteNode()
    var rateBtn = SKSpriteNode()
    var leaderboardBtn = SKSpriteNode()
    var musicBtn = SKSpriteNode()
    var tutorialBtn = SKSpriteNode()
    
    var light = SKLightNode()
    
    override func didMoveToView(view: SKView) {
        
        initialize()
        
        if soundOn == true {
            
            musicBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOn")))
        } else {
            
            musicBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOff")))
        }
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
            
            if nodeAtPoint(location) == musicBtn {
                
                playSound3()
                soundBtnPressed()
            }
            
            if nodeAtPoint(location) == tutorialBtn {
                
                playSound3()
                createTutorialAlertView()
            }
            
            if nodeAtPoint(location) == rateBtn {
                
                playSound3()
                rateBtnPressed()
            }
            
            if nodeAtPoint(location) == leaderboardBtn {
                
                playSound3()
                leaderboardBtnPressed()
                
            }
            
        }
    }
    
    func initialize() {
        authenticateLocalPlayer()
        
        setTitle()
        createPlayBtn()
        createRateBtn()
        createMusicBtn()
        createLeaderboardBtn()
        createTutorialBtn()
    }
    
    func setTitle() {
        
        title = SKLabelNode(fontNamed: "Prototype")
        title.name = "Title"
        title.zPosition = 3
        title.fontSize = 160
        title.fontColor = SKColor.whiteColor()
        title.text = "Tappy Lights"
        
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
    
    func createRateBtn() {
        
        rateBtn = SKSpriteNode(imageNamed: "RateBtn")
        rateBtn.name = "Rate"
        rateBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rateBtn.zPosition = 3
        rateBtn.size = CGSize(width: 150, height: 150)
        rateBtn.position = CGPoint(x: -110, y: playBtn.position.y - 650)
        
        self.addChild(rateBtn)
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
    
    func createLeaderboardBtn() {
        
        leaderboardBtn = SKSpriteNode(imageNamed: "LeaderboardBtn")
        leaderboardBtn.name = "Leaderboard"
        leaderboardBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leaderboardBtn.zPosition = 3
        leaderboardBtn.size = CGSize(width: 150, height: 150)
        leaderboardBtn.position = CGPoint(x: 110, y: playBtn.position.y - 650)
        
        self.addChild(leaderboardBtn)
    }
    
    func createTutorialBtn() {
        
        tutorialBtn = SKSpriteNode(imageNamed: "TutorialBtn2")
        tutorialBtn.name = "Tutorial"
        tutorialBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        tutorialBtn.zPosition = 3
        tutorialBtn.size = CGSize(width: 150, height: 150)
        tutorialBtn.position = CGPoint(x: -330, y: playBtn.position.y - 650)
        
        self.addChild(tutorialBtn)
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
    
    func createTutorialAlertView() {
        let alert = UIAlertController(title: "How-To-Play", message: "Tap every button thats lights up as fast as you can...avoid tapping any unlit button or it is GAMEOVER!", preferredStyle: UIAlertControllerStyle.Alert)
        let okay = UIAlertAction(title: "Let's Play", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(okay)
        
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        
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
    
    //initiate gamecenter
    func authenticateLocalPlayer(){
        
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            
            if (viewController != nil) {
                self.view?.window?.rootViewController?.presentViewController(viewController!, animated: true, completion: nil)
                
            }
                
            else {
                print((GKLocalPlayer.localPlayer().authenticated))
            }
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
    
}





































