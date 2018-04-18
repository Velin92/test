//
//  GameScene.swift
//  test Shared
//
//  Created by Andrea Vignali on 17/04/2018.
//  Copyright © 2018 Andrea Vignali. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var character: Character!
    var gvController: GameViewController!
    var entityManager: EntityManager!
    var lastTime: TimeInterval = 0
    
    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    override func didMove(to view: SKView) {
        if let skView = view as? GameView {
            gvController = skView.delegate as! GameViewController
        }
        entityManager = EntityManager(scene: self)
        character = Character()
        entityManager.add(character)
        
        
    }
    
    func setUpScene() {
        
    }
    

    override func update(_ currentTime: TimeInterval) {
        if lastTime == 0 {
            lastTime = currentTime
        }
        let deltaTime = currentTime - lastTime
        if let movementComponent = character.component(ofType: MovementComponent.self) {
            movementComponent.direction = gvController.controllerStoredDirection
        }
        entityManager.updateEntities(deltaTime: deltaTime)
        lastTime = currentTime
    }
}

#if os(tvOS)
// Touch-based event handling
extension GameScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
   
}
#endif

#if os(OSX)
// Mouse-based event handling
extension GameScene {

    override func mouseDown(with event: NSEvent) {
    }
    
    override func mouseDragged(with event: NSEvent) {
    }
    
    override func mouseUp(with event: NSEvent) {
    }

}
#endif

