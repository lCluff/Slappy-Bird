//
//  GameScene.swift
//  Slappy bird
//
//  Created by Leah Cluff on 7/3/19.
//  Copyright © 2019 Leah Cluff. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let Ghost : UInt64 = 0x1 << 1
    static let Ground : UInt64 = 0x1 << 2
    static let Wall : UInt64 = 0x1 << 3
}

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var Ground = SKSpriteNode()
    var Ghost = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        Ground = SKSpriteNode(imageNamed:"ground")
        Ground.setScale(0.5)
     
        
        Ground.physicsBody = SKPhysicsBody(rectangleOf: Ground.size)
        Ground.physicsBody?.categoryBitMask = UInt32(UInt64(PhysicsCategory.Ground))
        Ground.physicsBody?.collisionBitMask = UInt32(UInt64(PhysicsCategory.Ghost))
        Ground.physicsBody?.contactTestBitMask = UInt32(UInt64(PhysicsCategory.Ghost))
        Ground.physicsBody?.affectedByGravity = false
        Ground.physicsBody?.isDynamic = false
        Ground.zPosition = 3
        
        Ground.position = CGPoint(x: self.frame.width / 2, y:0 + Ground.frame.height / 2)
        self.addChild(Ground)
        
        
        Ghost = SKSpriteNode(imageNamed: "sprite")
        Ghost.size = CGSize(width: 60, height: 70)
        Ghost.position = CGPoint(x: self.frame.width / 2 - Ghost.frame.width, y: self.frame.height / 2)
        self.addChild(Ghost)
        
        Ghost.physicsBody = SKPhysicsBody(circleOfRadius: Ghost.frame.height / 2)
        Ghost.physicsBody?.categoryBitMask = UInt32(UInt64(PhysicsCategory.Ghost))
        Ghost.physicsBody?.collisionBitMask = UInt32(UInt64(PhysicsCategory.Ground | PhysicsCategory.Wall))
        Ghost.physicsBody?.contactTestBitMask = UInt32(UInt64(PhysicsCategory.Ground | PhysicsCategory.Wall))
        Ghost.physicsBody?.affectedByGravity = true
        Ghost.physicsBody?.isDynamic = true
        Ghost.zPosition = 2
    }
    
    
//    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
//    }
//
//    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
//    }
    func createWalls() {
        let wallPair = SKNode()
        
        let topWall = SKSpriteNode(imageNamed: "wall")
        let bottomWall = SKSpriteNode(imageNamed: "wall")
        
        topWall.position = CGPoint(x: self.frame.width, y: self.frame.height / 2 + 350)
        bottomWall.position = CGPoint(x: self.frame.width , y: self.frame.height / 2 - 350)
        
        topWall.setScale(0.5)
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        topWall.physicsBody?.categoryBitMask = UInt32(UInt64(PhysicsCategory.Wall))
        topWall.physicsBody?.collisionBitMask = UInt32(UInt64(PhysicsCategory.Ghost))
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.affectedByGravity = false
        topWall.zRotation = CGFloat(Double.pi)
        
        bottomWall.setScale(0.5)
        bottomWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        bottomWall.physicsBody?.categoryBitMask = UInt32(UInt64(PhysicsCategory.Wall))
        bottomWall.physicsBody?.collisionBitMask = UInt32(UInt64(PhysicsCategory.Ghost))
        bottomWall.physicsBody?.isDynamic = false
        bottomWall.physicsBody?.affectedByGravity = false
        bottomWall.zRotation = CGFloat(Double.pi)
        
        wallPair.addChild(topWall)
        wallPair.addChild(bottomWall)
        self.addChild(wallPair)
        
        wallPair.zPosition = 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        Ghost.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        Ghost.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 90))
      
    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//    
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
