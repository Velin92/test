//
//  GameControls.swift
//  test
//
//  Created by Andrea Vignali on 17/04/2018.
//  Copyright © 2018 Andrea Vignali. All rights reserved.
//

import simd
import GameController

#if os(OSX)

protocol KeyboardAndMouseEventsDelegate {
    func mouseDown(in view: NSView, with event: NSEvent) -> Bool
    func mouseDragged(in view: NSView, with event: NSEvent) -> Bool
    func mouseUp(in view: NSView, with event: NSEvent) -> Bool
    func keyDown(in view: NSView, with event: NSEvent) -> Bool
    func keyUp(in view: NSView, with event: NSEvent) -> Bool
}

private enum KeyboardDirection : UInt16 {
    case left   = 123
    case right  = 124
    case down   = 125
    case up     = 126
    
    var vector : float2 {
        switch self {
        case .up:    return float2( 0, 1)
        case .down:  return float2( 0,  -1)
        case .left:  return float2(-1,  0)
        case .right: return float2( 1,  0)
        }
    }
}

extension GameViewController: KeyboardAndMouseEventsDelegate {
}

#endif

extension GameViewController {
    
    // MARK: Controller orientation
    
    private static let controllerAcceleration = Float(1.0 / 10.0)
    private static let controllerDirectionLimit = float2(1.0)
    
    internal func controllerDirection() -> float2 {
        // Poll when using a game controller
        if let dpad = controllerDPad {
            if dpad.xAxis.value == 0.0 && dpad.yAxis.value == 0.0 {
                controllerStoredDirection = float2(0.0)
            } else {
                controllerStoredDirection = clamp(controllerStoredDirection + float2(dpad.xAxis.value, -dpad.yAxis.value) * GameViewController.controllerAcceleration, min: -GameViewController.controllerDirectionLimit, max: GameViewController.controllerDirectionLimit)
            }
        }
        
        return controllerStoredDirection
    }
    
    // MARK: Game Controller Events
    
    internal func setupGameControllers() {
        #if os(OSX)
        gameView.eventsDelegate = self
        #endif
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.handleControllerDidConnectNotification(_:)), name: .GCControllerDidConnect, object: nil)
    }
    
    @objc func handleControllerDidConnectNotification(_ notification: NSNotification) {
        let gameController = notification.object as! GCController
        registerCharacterMovementEvents(gameController)
    }
    
    private func registerCharacterMovementEvents(_ gameController: GCController) {
        
        // An analog movement handler for D-pads and thumbsticks.
        let movementHandler: GCControllerDirectionPadValueChangedHandler = { [unowned self] dpad, _, _ in
            self.controllerDPad = dpad
        }
        
        #if os(tvOS)
        
        // Apple TV remote
        if let microGamepad = gameController.microGamepad {
            // Allow the gamepad to handle transposing D-pad values when rotating the controller.
            microGamepad.allowsRotation = true
            microGamepad.dpad.valueChangedHandler = movementHandler
        }
        
        #endif
        
        // Gamepad D-pad
        if let gamepad = gameController.gamepad {
            gamepad.dpad.valueChangedHandler = movementHandler
        }
        // Extended gamepad left thumbstick
        if let extendedGamepad = gameController.extendedGamepad {
            extendedGamepad.leftThumbstick.valueChangedHandler = movementHandler
        }
    }

    // MARK: Mouse and Keyboard Events

    #if os(OSX)
    
    func mouseDown(in view: NSView, with event: NSEvent) -> Bool {
        // Remember last mouse position for dragging.
        lastMousePosition = float2(Float(view.convert(event.locationInWindow, from: nil).x),Float(view.convert(event.locationInWindow, from: nil).y))
        print("mouseDown:", lastMousePosition)
        return true
    }
    
    func mouseDragged(in view: NSView, with event: NSEvent) -> Bool {
        return true
    }
    
    func mouseUp(in view: NSView, with event: NSEvent) -> Bool {
        print("mouseUp")
        return true
    }
    
    func keyDown(in view: NSView, with event: NSEvent) -> Bool {
        print("keyDown", event.keyCode)
        if let direction = KeyboardDirection(rawValue: event.keyCode) {
            if !event.isARepeat {
                controllerStoredDirection += direction.vector
            }
            print(controllerStoredDirection)
            return true
        }
        
        return false
    }
    
    func keyUp(in view: NSView, with event: NSEvent) -> Bool {
        print("keyUp", event.keyCode)
        if let direction = KeyboardDirection(rawValue: event.keyCode) {
            if !event.isARepeat {
                controllerStoredDirection -= direction.vector
            }
            return true
        }
        
        return false
    }
    
    #endif
}
