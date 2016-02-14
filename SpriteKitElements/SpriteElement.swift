//
//  SpriteElement.swift
//  SpriteKitElements
//
//  Created by Nicholas Cross on 12/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation
import SpriteKit

public protocol SpriteElement : class {

    func didAttach(node: SKNode, inScene scene:SpriteElementScene)

    func update(currentTime: NSTimeInterval, delta: NSTimeInterval, node: SKNode)

    func didEvaluateActions(node: SKNode)

    func didSimulatePhysics(node: SKNode)

    func didApplyConstraints(node: SKNode)

    func didFinishUpdate(node: SKNode)

    func didMoveToView(view: SKView!, node: SKNode)

    func willMoveFromView(view: SKView!, node: SKNode)

    func didChangeSize(oldSize: CGSize, node: SKNode)

    func didBeginContact(contact: SKPhysicsContact, node: SKNode)
    
    func didEndContact(contact: SKPhysicsContact, node: SKNode)
}

public extension SpriteElement {
    func didAttach(node: SKNode, inScene scene:SpriteElementScene) {
        
    }
    
    func update(currentTime: NSTimeInterval, delta: NSTimeInterval, node: SKNode) {
        
    }
    
    func didEvaluateActions(node: SKNode) {
        
    }
    
    func didSimulatePhysics(node: SKNode) {
        
    }
    
    func didApplyConstraints(node: SKNode) {
        
    }
    
    func didFinishUpdate(node: SKNode) {
        
    }
    
    func didMoveToView(view: SKView!, node: SKNode) {
        
    }
    
    func willMoveFromView(view: SKView!, node: SKNode) {
        
    }
    
    func didChangeSize(oldSize: CGSize, node: SKNode) {
        
    }
    
    func didBeginContact(contact: SKPhysicsContact, node: SKNode) {
        
    }
    
    func didEndContact(contact: SKPhysicsContact, node: SKNode) {
        
    }

}