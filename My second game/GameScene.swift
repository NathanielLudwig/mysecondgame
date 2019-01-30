//
//  GameScene.swift
//  My second game
//
//  Created by 90303054 on 10/8/18.
//  Copyright © 2018 90303054. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let impact = UIImpactFeedbackGenerator()
    var ball = SKSpriteNode()
    var ball2 = SKSpriteNode()
    var ball3 = SKSpriteNode()
    var touchPoint: CGPoint = CGPoint()
    var touching: Bool = false
    var touch = UITouch()
    let spinsound = SKAudioNode(fileNamed: "fidget.mp3")

    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        ball2 = self.childNode(withName: "ball2") as! SKSpriteNode
        ball3 = self.childNode(withName: "ball3") as! SKSpriteNode
       
        ball2.physicsBody?.applyImpulse(CGVector(dx: 100, dy: 100))
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 0.5
        self.physicsBody = border
        physicsWorld.contactDelegate = self
        spinsound.autoplayLooped = true
        addChild(spinsound)
        spinsound.run(SKAction.stop())
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in:self)
        if ball.frame.contains(location) {
            touchPoint = location
            touching = true
            spinsound.run(SKAction.play())
            
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touch = touches.first!
        let location = touch.location(in: self)
        touchPoint = location
        
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touching = false
       // spinsound.removeFromParent()
        spinsound.run(SKAction.stop())
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.node?.name == "ball" || contact.bodyB.node?.name == "ball" {
           // ball2.removeFromParent()
            run(SKAction.playSoundFileNamed("oof.wav", waitForCompletion: false))
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if touching {
            
            if view!.traitCollection.forceTouchCapability == .available {
                if touch.force == touch.maximumPossibleForce {
                    
                      ball.physicsBody?.applyAngularImpulse(5.0)
                      // impact.impactOccurred()
                      // run(SKAction.playSoundFileNamed("fidget-spinner-sound-effects-1Skvi4zd4l.mp3",       waitForCompletion: false))
                    spinsound.run(SKAction.changeVolume(to: 1.0, duration: 0.5))
                    
                    
                    
                } else {
                    ball.physicsBody?.applyAngularImpulse(0.5)
                      spinsound.run(SKAction.changeVolume(to: 0.1, duration: 0.5))
                }
                
                
            }
            
        }
    // if ball2.position.y < -1000 {
  //       ball2.position.y = 0
//  }
//        if ball3.position.y < -1000 {
//            ball3.position.y = 0
//        }
    }
}
