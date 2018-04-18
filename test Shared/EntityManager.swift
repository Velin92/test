//
//  EntityManager.swift
//  test
//
//  Created by Andrea Vignali on 17/04/2018.
//  Copyright © 2018 Andrea Vignali. All rights reserved.
//


import Foundation
import SpriteKit
import GameplayKit

class EntityManager {
    var entities = Set<GKEntity>()
    let scene: SKScene
    var toRemove = Set<GKEntity>()
    
    public init(scene: SKScene) {
        self.scene = scene
    }
    
    func add(_ entity: GKEntity) {
        entities.insert(entity)
        
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.spriteNode {
            scene.addChild(spriteNode)
        }
    }
    
    func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.spriteNode {
            spriteNode.removeFromParent()
        }
        
        entities.remove(entity)
        toRemove.insert(entity)
    }
    
    func updateEntities(deltaTime: TimeInterval){
        for entity in entities {
            entity.update(deltaTime: deltaTime)
        }
    }
}
