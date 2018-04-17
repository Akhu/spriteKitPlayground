//
//  GameScene.swift
//  SpriteKit Demo
//
//  Created by Anthony Da Cruz on 08/03/2018.
//  Copyright © 2018 Anthony Da Cruz. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    var motion:CMMotionManager = CMMotionManager()
    
    let dogSpriteNode = SKSpriteNode(imageNamed: "Run0")
    let spaceShiptSpriteNode = SKSpriteNode(imageNamed: "Spaceship")
    var dogFrames = [SKTexture]()
    //@todo => acceder à l'accelerometre pour faire changer la gravité
    override func didMove(to view: SKView) {
        
        self.dogSpriteNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.dogSpriteNode.scale(to: CGSize(width: self.dogSpriteNode.size.width/2, height: self.dogSpriteNode.size.height/2))
        
        self.spaceShiptSpriteNode.scale(to: CGSize(width: self.spaceShiptSpriteNode.size.width/2, height: self.spaceShiptSpriteNode.size.height/2))
        self.spaceShiptSpriteNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        self.addChild(self.spaceShiptSpriteNode)
        self.addChild(self.dogSpriteNode)
        
        let textureAtlas = SKTextureAtlas(named: "Dog Frames")
        
        self.dogFrames = textureAtlas.textureNames.enumerated().map { (index, name) in
            textureAtlas.textureNamed("Run" + String(index))
        }
        
        self.physicsWorld.gravity = CGVector(dx: -1.0, dy: -2.0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        self.dogSpriteNode.physicsBody = SKPhysicsBody(circleOfRadius: self.dogSpriteNode.frame.size.height/2)
        self.dogSpriteNode.physicsBody?.isDynamic = true
        self.dogSpriteNode.physicsBody?.restitution = 0.8
        
        self.spaceShiptSpriteNode.physicsBody = SKPhysicsBody(circleOfRadius: self.spaceShiptSpriteNode.frame.size.height/2)
        self.spaceShiptSpriteNode.physicsBody?.isDynamic = true
        self.spaceShiptSpriteNode.physicsBody?.restitution = 0.6
        self.motion.startAccelerometerUpdates()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        print("1")
        if let data = self.motion.accelerometerData {
            self.physicsWorld.gravity = CGVector(dx: data.acceleration.x * 50, dy: data.acceleration.y * 50)
        }
//        if let data = motionManager.accelerometerData? {
//            vec = CGVectorMake(CGFloat(data.acceleration.x), CGFloat(data.acceleration.y))
//        }
        //getting motion manager and mapping with CGVector
    }
    
    
    override func didEvaluateActions() {
        print("2")
    }
    
    override func didSimulatePhysics() {
        print("3")
    }
    
    override func didApplyConstraints() {
        print("4")
    }
    
    override func didFinishUpdate() {
        print("5")
        self.isPaused = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !dogSpriteNode.hasActions() {
            self.dogSpriteNode.run(SKAction.repeatForever(SKAction.animate(with: self.dogFrames, timePerFrame: 0.1)))
        }else {
            dogSpriteNode.removeAllActions()
        }
        
        self.dogSpriteNode.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 10.0))
    }
}
