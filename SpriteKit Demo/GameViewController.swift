//
//  GameViewController.swift
//  SpriteKit Demo
//
//  Created by Anthony Da Cruz on 08/03/2018.
//  Copyright © 2018 Anthony Da Cruz. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            //let scene = GameScene(size: view.bounds.size)
            if let scene = SKScene(fileNamed: "FileTileMapScene") {
                    
                scene.scaleMode = .aspectFill
                
                view.presentScene(scene)
                /**
                 Not paying attention to the order of node are added, good thing for performance, cause iOS Will decide order, but we cannot be sure that objects will be drawn and displayed the way we want
                 */
                view.ignoresSiblingOrder = true
                view.showsFPS = true //Show FPS
                view.showsNodeCount = true //Nodes drawn
                view.showsPhysics = true
            }
        }
    }
}
