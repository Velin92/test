//
//  GameViewController.swift
//  test
//
//  Created by Andrea Vignali on 17/04/2018.
//  Copyright © 2018 Andrea Vignali. All rights reserved.
//

import simd
import SpriteKit
import GameController

#if os(iOS) || os(tvOS)
typealias ViewController = UIViewController
#elseif os(OSX)
typealias ViewController = NSViewController
#endif

class GameViewController: ViewController, SKViewDelegate {
    
    //Game Controllers
    internal var controllerDPad: GCControllerDirectionPad?
    internal var controllerStoredDirection = float2(0.0) // left/right up/down
    #if os(OSX)
    internal var lastMousePosition = float2(0)
    #endif
    
    @objc var gameView: GameView {
        return view as! GameView
    }
    // MARK: Initialization
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene.newGameScene()
        let skView = view as! SKView
        gameView.delegate = self
        scene.setUpScene()
        skView.presentScene(scene)

        skView.ignoresSiblingOrder = true
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        self.setupGameControllers()
    }
}
