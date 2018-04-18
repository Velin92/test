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
        let module = sqrt(dx*dx + dy*dy) == 0 ? 1.0 : sqrt(dx*dx + dy*dy)
        node.position.x += CGFloat(dx)/CGFloat(module)
        node.position.y += CGFloat(dy)/CGFloat(module)
        print(node.position.x, node.position.y, "dx:", CGFloat(dx)/CGFloat(module), "dy:", CGFloat(dy)/CGFloat(module))
    }
    
    func addNode(node: SKNode) {
        self.node = node
    }
    
    
}
