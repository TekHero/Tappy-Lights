//
//  GameManager.swift
//  Tappy Lights
//
//  Created by Brian Lim on 6/16/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import Foundation
import SpriteKit

class GameManager {
    
    static var instance = GameManager()
    private init() {}
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    // Saving and Grabbing highscores
    func setHighscore(highscore: Int) {
        NSUserDefaults.standardUserDefaults().setInteger(highscore, forKey: "HIGHSCORE")
    }
    
    func getHighscore() -> Int {
        return NSUserDefaults.standardUserDefaults().integerForKey("HIGHSCORE")
    }
}