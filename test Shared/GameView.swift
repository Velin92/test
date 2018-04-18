//
//  GameView.swift
//  test
//
//  Created by Andrea Vignali on 17/04/2018.
//  Copyright © 2018 Andrea Vignali. All rights reserved.
//

import simd
import SpriteKit

class GameView: SKView {
    // MARK: Mouse and Keyboard Events
    
    #if os(OSX)
    
    var eventsDelegate: KeyboardAndMouseEventsDelegate?
    
    override func mouseDown(with event: NSEvent) {
        guard let eventsDelegate = eventsDelegate, eventsDelegate.mouseDown(in: self, with: event) else {
            super.mouseDown(with: event)
            return
        }
    }
    
    override func mouseDragged(with event: NSEvent) {
        guard let eventsDelegate = eventsDelegate, eventsDelegate.mouseDragged(in: self, with: event) else {
            super.mouseDragged(with: event)
            return
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        guard let eventsDelegate = eventsDelegate, eventsDelegate.mouseUp(in: self, with: event) else {
            super.mouseUp(with: event)
            return
        }
    }
    
    override func keyDown(with event: NSEvent) {
        guard let eventsDelegate = eventsDelegate, eventsDelegate.keyDown(in: self, with: event) else {
            super.keyDown(with: event)
            return
        }
    }
    
    override func keyUp(with event: NSEvent) {
        guard let eventsDelegate = eventsDelegate, eventsDelegate.keyUp(in: self, with: event) else {
            super.keyUp(with: event)
            return
        }
    }
    
    
    #endif
}
