//
//  MovementComponent.swift
//  test
//
//  Created by Mauro Romito on 18/04/18.
//  Copyright © 2018 Andrea Vignali. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit
import simd

class MovementComponent: GKComponent {
    
    var node: SKNode!
    var direction: float2 = float2(0.0)
    var speed: Float = 100.0
    
   
    
    
    
    
    override func update(deltaTime seconds: TimeInterval) {
        let dx = Float(direction.x) * speed * Float(seconds)
        let dy = Float(direction.y) * speed * Float(seconds)
        node.position.x += CGFloat(dx)
        node.position.y += CGFloat(dy)
    }
    
    func addNode(node: SKNode) {
        self.node = node
    }
    
    
}
