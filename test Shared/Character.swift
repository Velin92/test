//
//  Character.swift
//  test
//
//  Created by Andrea Vignali on 17/04/2018.
//  Copyright © 2018 Andrea Vignali. All rights reserved.
//

import SpriteKit
import GameplayKit

class Character: GKEntity {
    init(imageName: String) {
        super.init()
        
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        addComponent(spriteComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SpriteComponent: GKComponent {
    
    let spriteNode: SKSpriteNode
    
    init(texture: SKTexture) {
        spriteNode = SKSpriteNode(texture: texture, color: .clear, size: texture.size())
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SKSpriteNode {
    @objc convenience init(imageNamed name: String, position: CGPoint, scale: CGFloat = 1.0) {
        self.init(imageNamed: name)
        self.position = position
        xScale = scale
        yScale = scale
    }
}
