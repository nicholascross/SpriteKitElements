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

    func didAttach(toNode node: SKNode, inScene scene:SpriteElementScene)

    func update(atTime currentTime: TimeInterval, delta: TimeInterval, node: SKNode)

    func didEvaluateActions(_ node: SKNode)

    func didSimulatePhysics(_ node: SKNode)

    func didApplyConstraints(_ node: SKNode)

    func didFinishUpdate(_ node: SKNode)

    func didMove(toView view: SKView, node: SKNode)

    func willMove(fromView view: SKView, node: SKNode)

    func didChange(size oldSize: CGSize, node: SKNode)

    func didBegin(contact: SKPhysicsContact, node: SKNode)
    
    func didEnd(contact: SKPhysicsContact, node: SKNode)
}

public extension SpriteElement {
    func didAttach(toNode node: SKNode, inScene scene:SpriteElementScene) {
        
    }
    
    func update(atTime currentTime: TimeInterval, delta: TimeInterval, node: SKNode) {
        
    }
    
    func didEvaluateActions(_ node: SKNode) {
        
    }
    
    func didSimulatePhysics(_ node: SKNode) {
        
    }
    
    func didApplyConstraints(_ node: SKNode) {
        
    }
    
    func didFinishUpdate(_ node: SKNode) {
        
    }
    
    func didMove(toView view: SKView, node: SKNode) {
        
    }
    
    func willMove(fromView view: SKView, node: SKNode) {
        
    }
    
    func didChange(size oldSize: CGSize, node: SKNode) {
        
    }
    
    func didBegin(contact: SKPhysicsContact, node: SKNode) {
        
    }
    
    func didEnd(contact: SKPhysicsContact, node: SKNode) {
        
    }
}
